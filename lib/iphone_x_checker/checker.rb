module IphoneXChecker
  class Checker
    # check every minute
    BETWEEN_CHECKS_COOLDOWN = 30

    def initialize
      @fetcher = Fetcher.new
      @notifier = Notifier.new
      @printer = Printer.new
    end

    def begin_checking
      loop do
        check_availability
        sleep(BETWEEN_CHECKS_COOLDOWN)
      end
    end

    private

    attr_reader :fetcher, :notifier, :printer

    def check_availability
      if response.available?
        notifier.notify
      else
        printer.print_timestamped(unavailable_message)
      end
    end

    def response
      Response.new(fetcher.fetch_data)
    end

    def unavailable_message
      "Not available"
    end
  end
end
