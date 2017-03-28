require 'capybara'
require 'capybara/dsl'
require_relative 'capybara_login_page'
require_relative '../utils/test_utils'

# Capybara.register_driver :ie do |app|
#   Capybara::Selenium::Driver.new(app, browser: :remote,
#                                  url: "http://192.168.0.102:5555/wd/hub/",
#                                  desired_capabilities: :ie)
# end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

[:selenium, :chrome].each do |driver|
  Capybara.current_driver = driver
  Capybara.app_host = 'http://demoapp.strongqa.com/'
  login_page = CapybaraLoginPage.new
  TestRun.run_test(page: login_page)
end
