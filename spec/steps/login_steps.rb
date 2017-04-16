module LoginSteps
  CORRECT_EMAIL = 'lec1k2103@gmail.com'.freeze
  CORRECT_PASS = 'testtest'.freeze

  step 'I am on login page' do
    Home.new.navigate_to_login_page
  end

  step 'I login with :email as an email and :password as a password with checked remember me' do |email, password|
    Login.new.log_in(email, password, true)
  end

  step 'I login with :email as an email and :password as a password with unchecked remember me' do |email, password|
    Login.new.log_in(email, password)
  end

  step 'I login with correct credentials' do
    Login.new.log_in(CORRECT_EMAIL, CORRECT_PASS)
  end

  step 'Log in should be succeeded' do
    expect(Web).to be_user_logged_in
  end

  step 'Log in should be failed' do
    expect(Web).to be_login_failed
  end
end

RSpec.configure { |c| c.include LoginSteps }
