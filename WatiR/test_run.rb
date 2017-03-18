require 'watir'
require_relative 'login_page'

b = Watir::Browser.new :chrome

login_page = LoginPage.new(browser: b)

login_page.public_methods(false).each { |method| login_page.send(method) if method.to_s.include? 'test'}


