Bundler.require(:test)
require_relative 'login_page'
require_relative '../utils/test_utils'
%i[chrome ff].each do |browser|
  b = Watir::Browser.new browser
  login_page = LoginPage.new(browser: b)
  TestRun.watir_run_test(page: login_page)
end
