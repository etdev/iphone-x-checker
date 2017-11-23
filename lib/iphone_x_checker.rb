require "rubygems"
require_relative "iphone_x_checker/checker"
require_relative "iphone_x_checker/notifier"
require_relative "iphone_x_checker/notifiers/email_notifier"
require_relative "iphone_x_checker/fetcher"
require_relative "iphone_x_checker/response"
require_relative "iphone_x_checker/printer"
require_relative "iphone_x_checker/parser"

IphoneXChecker::Checker.new.begin_checking
