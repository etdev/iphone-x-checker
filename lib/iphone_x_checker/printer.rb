module IphoneXChecker
  class Printer
    def print_timestamped(message)
      puts "#{message} [#{current_time_jst}]"
    end

    private

    def current_time_jst
      (Time.now + (9 * 3600)).strftime("%Y-%m-%d %H:%M:%S")
    end
  end
end
