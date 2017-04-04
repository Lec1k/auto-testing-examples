Bundler.setup(:test)
require_relative '../capybara/home'

CORRECT_EMAIL = 'lec1k2103@gmail.com'.freeze
CORRECT_PASS = 'testtest'.freeze
INCORRECT_EMAIL = 'test@test.com'.freeze
INCORRECT_PASS = 'qwertqwer'.freeze

RSpec.shared_examples 'successful_login' do |email, pass, remember_me|
  let(:login_page) { Login.new }
  it 'successfully logins with correct credentials' do
    expect(login_page.log_in(email, pass, remember_me).user_logged_in?)
  end
end

RSpec.shared_examples 'failed_login' do |email, pass, remember_me|
  let(:login_page) { Login.new }
  it 'fails to login with incorrect credentials' do
    login_page.log_in(email, pass, remember_me)
    expect(login_page.login_failed?).to be_truthy
  end
end

RSpec.describe Home do
  after(:each) { Capybara.reset_sessions! }
  describe '#navigate_to_login_page' do
    it 'allows navigation to login page' do
      expect(Home.new.navigate_to_login_page).to be_a(Login)
    end
  end
  describe '#logout' do
    it 'logs out user' do
      home = Login.new.log_in(CORRECT_EMAIL,CORRECT_PASS)
      expect(home.user_logged_in?)
    end
  end
end

RSpec.describe Login do
  after(:each) { Capybara.reset_sessions! }
  include_examples 'successful_login', CORRECT_EMAIL, CORRECT_PASS, false
  include_examples 'successful_login', CORRECT_EMAIL, CORRECT_PASS, true
  include_examples 'failed_login', CORRECT_EMAIL, INCORRECT_PASS, false
  include_examples 'failed_login', INCORRECT_EMAIL, CORRECT_PASS, false
  include_examples 'failed_login', INCORRECT_EMAIL, INCORRECT_PASS, false
  include_examples 'failed_login', '', CORRECT_PASS, false
  include_examples 'failed_login', CORRECT_EMAIL, '', false
  include_examples 'failed_login', '', '', false
end
