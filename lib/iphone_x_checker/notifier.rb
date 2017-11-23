module IphoneXChecker
  class Notifier
    # after notifying, wait an hour before checking again
    POST_NOTIFICATION_COOLDOWN = 3600

    def initialize(notifier = Notifiers::EmailNotifier)
      @notifier = notifier.new
      @printer = Printer.new
    end

    def notify
      notifier.notify
      printer.print_timestamped(notification_sent_message)
      sleep(POST_NOTIFICATION_COOLDOWN)
    end

    private

    attr_reader :notifier, :printer

    def notification_sent_message
      "Available - notification sent"
    end
  end
end
