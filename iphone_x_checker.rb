require "rubygems"
require "rest-client"
require "json"
require_relative "iphone_x_checker/checker"
require_relative "iphone_x_checker/emailer"

IphoneXChecker::Checker.new.begin_checking
