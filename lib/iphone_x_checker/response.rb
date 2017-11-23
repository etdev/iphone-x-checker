require "rest-client"

module IphoneXChecker
  class Response
    STORE_NAMES = %w(渋谷 表参道 銀座).freeze
    MODEL_NUMBER = "MQAY2J/A".freeze

    def initialize(raw_data)
      @data = parser.parse(raw_data)
    end

    def available?
      statuses.any? { |status| !unavailable_statuses.include?(status) }
    end

    private

    attr_reader :data

    def parser
      @_parser ||= Parser.new
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

    def unavailable_statuses
      %w(ineligible unavailable)
    end
  end
end
