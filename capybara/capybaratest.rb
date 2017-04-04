Bundler.require(:test)
require_relative '../utils/test_utils'
require_relative 'app_test'

# Capybara.register_driver :ie do |app|
#   Capybara::Selenium::Driver.new(app, browser: :remote,
#                                  url: "http://192.168.0.102:5555/wd/hub/",
#                                  desired_capabilities: :ie)
# end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

# %i(selenium chrome).each do |driver|
#   Capybara.current_driver = driver
#   Capybara.app_host = 'http://demoapp.strongqa.com/'
#   login_page = CapybaraLoginPage.new
#   TestRun.run_test(page: login_page)
# end

Capybara.current_driver = :chrome
Capybara.app_host = 'http://demoapp.strongqa.com/'
TestRun.run_test(AppTest.new)
# AppTest.new.logout_test
