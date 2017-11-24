require "json"

module IphoneXChecker
  class Parser
    def initialize(parser = JSON)
      @parser = parser
    end

    def parse(data)
      parser.parse(data)
    end

    private

    attr_reader :parser
  end
end
