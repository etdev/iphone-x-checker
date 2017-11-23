require "net/smtp"

module IphoneXChecker
  class Emailer
    def send_email
      server = Net::SMTP.new(smtp_host, port)
      server.enable_starttls

      start_email_send(server)
    end

    private

    def message
      <<~MSG
        From: #{name} <#{address}>
        To: #{name} <#{address}>
        Subject: #{message_subject}

        #{message_body}

      MSG
    end

    def start_email_send(server)
      server.start(host, address, password, :login) do |smtp|
        smtp.send_message(
          message,
          address,
          address
        )
      end
    end

    # host name for your server
    def host
      ENV["HOST"] || "gmail.com"
    end

    # host name for the smpt server
    def smtp_host
      ENV["SMTP_HOST"] || "smtp.gmail.com"
    end

    def name
      ENV["NAME"]
    end

    def port
      ENV["PORT"] || 587
    end

    def address
      ENV["ADDRESS"]
    end

    def password
      ENV["PASSWORD"]
    end

    def message_subject
      "iPhone X is available!"
    end

    def message_body
      <<~BODY
        THE IPHONE X IS AVAILABLE:
        https://www.apple.com/jp/shop/buy-iphone/iphone-x#00,10
      BODY
    end
  end
end
