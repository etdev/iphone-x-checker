module IphoneXChecker
  class Checker
    URL = "https://www.apple.com/jp/shop/retail/pickup-message?pl=true&parts.0=MQAY2J/A&location=106-0031".freeze
    # 64GB silver - this and URL need to be changed otherwise
    MODEL_NUMBER = "MQAY2J/A".freeze
    STORE_NAMES = %w(渋谷 表参道 銀座).freeze

    MAX_TRIES_PER_ROUND = 2
    # check every minute
    BETWEEN_CHECKS_COOLDOWN = 60
    # after notifying twice, wait an hour before checking again
    BETWEEN_ROUNDS_COOLDOWN = 3600

    def initialize
      reset_tries
      @data = {}
    end

    def begin_checking
      loop do
        with_tries_checking do
          check_availability
        end

        sleep(BETWEEN_CHECKS_COOLDOWN)
      end
    end

    private

    attr_reader :data, :tries

    def check_availability
      fetch_data

      if available?
        send_notification
      else
        print_unavailable_message
      end
    end

    def fetch_data
      @data = JSON.parse(RestClient.get(URL))
    end

    def stores
      @_stores ||= data
        .dig("body", "stores")
        .select { |store| STORE_NAMES.include?(store["storeName"]) }
    end

    def statuses
      stores.map do |store|
        store.dig("partsAvailability", MODEL_NUMBER, "pickupDisplay")
      end
    end

    def available?
      !statuses.any? { |status| !%w(ineligible unavailable).include? status }
    end

    def send_notification
      Emailer.new.send_email
      puts "Available - notification sent [#{current_time_jst}]"
    end

    def current_time_jst
      (Time.now + (9 * 3600)).strftime("%Y-%m-%d %H:%M:%S")
    end

    def check_tries
      return unless tries == MAX_TRIES_PER_ROUND
      sleep(BETWEEN_ROUNDS_COOLDOWN)
      reset_tries
    end

    def reset_tries
      @tries = 0
    end

    def increment_tries
      @tries += 1
    end

    def with_tries_checking
      check_tries
      yield
      increment_tries
    end

    def print_unavailable_message
      puts "Not available [#{current_time_jst}]"
    end
  end
end
