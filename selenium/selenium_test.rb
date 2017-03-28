require 'selenium-webdriver'
require_relative 'selenium_login_page'
require_relative '../utils/test_utils'
[:chrome, :ff].each do |browser|
  b = Selenium::WebDriver.for browser
  login_page = SeleniumLoginPage.new(browser: b)
  TestRun.run_test(page: login_page)
end
#
#   b = Selenium::WebDriver.for(
#   :remote,
#   url: 'http://192.168.0.102:5555/wd/hub/',
#   desired_capabilities: :ie)
#   login_page = SeleniumLoginPage.new(browser: b)
#   login_page.public_methods(false).each do |method|
#     begin
#       login_page.send(method) if method.to_s.include? 'test'
#     rescue Selenium::WebDriver::Error::TimeOutError => e
#       puts "#{b.browser}: #{method} FAILED: #{e.message}"
#     end
#   end
#   login_page.close_page
