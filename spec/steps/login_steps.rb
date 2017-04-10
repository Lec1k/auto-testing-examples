module LoginSteps
  CORRECT_EMAIL = 'lec1k2103@gmail.com'.freeze
  CORRECT_PASS = 'testtest'.freeze

  step 'I am on login page' do
    Home.new.navigate_to_login_page
  end

  step 'I login with :email as an email and :password as a password with :checked remember me' do |email, password, checked|
    if checked == 'checked'
      Login.new.log_in(email, password, true)
    else
      Login.new.log_in(email, password)
    end
  end

  step 'I login with correct credentials' do
    Login.new.log_in(CORRECT_EMAIL, CORRECT_PASS)
  end

  step 'Log in should be :state' do |state|
    if state == 'succeeded'
      expect(Web.user_logged_in?).to be_truthy
    else
      expect(Web.login_failed?).to be_truthy
    end
  end
end

RSpec.configure { |c| c.include LoginSteps }
