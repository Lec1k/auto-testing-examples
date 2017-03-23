require 'selenium-webdriver'
require_relative 'selenium_login_page'

[:chrome, :ff].each do |browser|
  b = Selenium::WebDriver.for browser
  login_page = SeleniumLoginPage.new(browser: b)
  login_page.public_methods(false).each do |method|
    begin
      login_page.send(method) if method.to_s.include? 'test'
    rescue Selenium::WebDriver::Error::TimeOutError => e
      puts "#{b.browser}: #{method} FAILED: #{e.message}"
    end
  end
  login_page.close_page
end
