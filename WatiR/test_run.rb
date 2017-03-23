require 'watir'
require_relative 'login_page'

[:chrome, :ff].each do |browser|
  b = Watir::Browser.new browser
  login_page = LoginPage.new(browser: b)
  login_page.public_methods(false).each do |method|
    begin
      login_page.send(method) if method.to_s.include? 'test'
    rescue Watir::Wait::TimeoutError => e
      puts "#{b.name}: #{method} FAILED: #{e.message}"
    end
  end
  login_page.close_page
end
