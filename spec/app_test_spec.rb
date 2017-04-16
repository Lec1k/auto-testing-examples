Bundler.setup(:test)
require_relative '../capybara/home'
require_relative '../capybara/web'

CORRECT_EMAIL = 'lec1k2103@gmail.com'.freeze
CORRECT_PASS = 'testtest'.freeze
INCORRECT_EMAIL = 'test@test.com'.freeze
INCORRECT_PASS = 'qwertqwer'.freeze

RSpec.shared_examples 'successful_login' do |email, pass, remember_me|
  let(:login_page) { Login.new }
  it 'successfully logins with correct credentials' do
    Home.new.navigate_to_login_page
    login_page.log_in(email, pass, remember_me)
    expect(Web).to be_user_logged_in
  end
end

RSpec.shared_examples 'failed_login' do |email, pass, remember_me|
  let(:login_page) { Login.new }
  it 'fails to login with incorrect credentials' do
    Home.new.navigate_to_login_page
    login_page.log_in(email, pass, remember_me)
    expect(Web).to be_login_failed
  end
end

RSpec.describe Home do
  describe '#navigate_to_login_page' do
    it 'allows navigation to login page' do
      Home.new.navigate_to_login_page
      expect(Web.current_page).to be_a(Login)
    end
  end
  describe '#logout' do
    it 'logs out user' do
      Home.new.navigate_to_login_page
      Login.new.log_in(CORRECT_EMAIL, CORRECT_PASS)
      expect(Web).to be_user_logged_in
    end
  end
end

RSpec.describe Login do
  include_examples 'successful_login', CORRECT_EMAIL, CORRECT_PASS, false
  include_examples 'successful_login', CORRECT_EMAIL, CORRECT_PASS, true
  include_examples 'failed_login', CORRECT_EMAIL, INCORRECT_PASS, false
  include_examples 'failed_login', INCORRECT_EMAIL, CORRECT_PASS, false
  include_examples 'failed_login', INCORRECT_EMAIL, INCORRECT_PASS, false
  include_examples 'failed_login', '', CORRECT_PASS, false
  include_examples 'failed_login', CORRECT_EMAIL, '', false
  include_examples 'failed_login', '', '', false
end
