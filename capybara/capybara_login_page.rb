Bundler.require(:test)
require_relative '../watir/login_page'

class CapybaraLoginPage < LoginPage
  include Capybara::DSL

  def initialize
    @browser = Capybara.current_session.driver.browser
    @browser_type = @browser.browser
  end

  private

  def login_navigation
    visit('/users/sign_in')
  end

  def login_with_credentials(*is_remember, login:, password:)
    fill_in('user_email', with: login)
    fill_in('user_password', with: password)
    check('user_remember_me') unless is_remember.empty?
    page.execute_script("document.
                              getElementsByClassName('checkbox')[0].remove()")
    click_on('Log in')
  end

  def login_fail?
    page.has_xpath?('id("flash_alert")[.="Invalid email or password."]')
  end

  def login_success?
    page.has_xpath?('id("flash_notice")[.="Signed in successfully."]')
  end

  def reset_cookies
    @browser.manage.delete_all_cookies
  end

  public

  def correct_credentials_test
    super
  end

  def login_blank_fields_test
    super
  end

  def login_blank_mail_test
    super
  end

  def login_blank_pass_test
    super
  end

  def login_incorrect_data_test
    super
  end

  def login_incorrect_mail_test
    super
  end

  def login_incorrect_pass_test
    super
  end

  def login_navigation_test
    login_navigation
    test_result_evaluate(condition: page.has_xpath?('id("new_user")'),
                         method: __method__)
  end

  def login_remembering_reopen_test
    login_navigation
    login_with_credentials(true, login: CORRECT_EMAIL, password: CORRECT_PASS)
    cookies = @browser.manage.all_cookies
    Capybara.reset_sessions!
    login_navigation
    cookies.each do |cookie|
      @browser.manage.add_cookie(cookie)
    end
    visit('/')
    visit('/')
    test_result_evaluate(condition: page.has_xpath?("//a[.='Logout']"),
                         method: __method__)
    reset_cookies
  end

  def login_remembering_test
    super
  end

  def logout_test
    login_navigation
    login_with_credentials(login: CORRECT_EMAIL, password: CORRECT_PASS)
    click_on('Logout')
    Capybara.reset_sessions!
    visit('/')
    test_result_evaluate(condition: page.has_xpath?("//a[.='Login']"),
                         method: __method__)
    reset_cookies
  end
end
