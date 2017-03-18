require 'watir'
require_relative 'login_page'

b = Watir::Browser.new :chrome

 login_page = LoginPage.new(browser: b)
 login_page.logout_test



