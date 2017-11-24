require "rest-client"

module IphoneXChecker
  class Fetcher
    URL = "https://www.apple.com/jp/shop/retail/pickup-message?pl=true&parts.0=MQAY2J/A&location=106-0031".freeze

    def fetch_data
      RestClient.get(URL)
    end
  end
end
