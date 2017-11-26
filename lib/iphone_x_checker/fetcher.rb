require "rest-client"

module IphoneXChecker
  class Fetcher
    URL = "https://www.apple.com/jp/shop/retail/pickup-message?pl=true&parts.0=MQAY2J/A&location=105-0001".freeze

    def fetch_data
      RestClient.get(URL)
    end
  end
end
