Bundler.require(:test)
require_relative '../watir/login_page'


class SeleniumLoginPage < LoginPage
  def initialize(browser:)
    @browser = browser
    @browser_type = browser.browser
    @wait = Selenium::WebDriver::Wait.new(timeout: 2)
  end

  private

  def login_navigation
    @browser.navigate.to('http://demoapp.strongqa.com/')
    @browser.find_element(:xpath, "//a[.='Login']").click
  end

  def login_success?
    @wait.until { @browser.find_element(:id, 'flash_notice').displayed? }
    @browser.find_element(:id, 'flash_notice').text == 'Signed in successfully.'
  end

  def login_fail?
    @wait.until { @browser.find_element(:id, 'flash_alert').displayed? }
    @browser.find_element(:id, 'flash_alert').text ==
      'Invalid email or password.'
  end

  def login_with_credentials(*is_remember, login:, password:)
    @wait.until { @browser.find_element(:id, 'user_email').displayed? }
    @browser.find_element(:id, 'user_email').send_keys(login)
    @browser.find_element(:id, 'user_password').send_keys(password)
    @browser.find_element(:id, 'user_remember_me').click unless is_remember.empty?
    @browser.execute_script("document.getElementsByClassName('checkbox')[0].remove()")
    @browser.find_element(:name, 'commit').click
  end

  def reset_cookies
    @browser.manage.delete_all_cookies
  end

  public

  def login_blank_fields_test
    super
  end

  def login_blank_mail_test
    super
  end

  def login_blank_pass_test
    super
  end

  def correct_credentials_test
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
    @wait.until { @browser.find_element(:id, 'new_user').displayed? }
    test_result_evaluate(condition: @browser.find_element(:id, 'new_user'),
                         method: __method__)
  end

  def login_remembering_reopen_test
    login_navigation
    login_with_credentials(true, login: CORRECT_EMAIL, password: CORRECT_PASS)
    cookies = @browser.manage.all_cookies
    close_page
    @browser = Selenium::WebDriver.for @browser_type
    login_navigation
    cookies.each do |cookie|
      @browser.manage.add_cookie(cookie)
    end
    login_navigation
    @wait.until { @browser.find_element(:xpath, "//a[.='Logout']").displayed? }
    test_result_evaluate(condition: @browser.find_element(:xpath, "//a[.='Logout']"),
                         method: __method__)
    reset_cookies
  end

  def login_remembering_test
    super
  end

  def logout_test
    login_navigation
    login_with_credentials(login: CORRECT_EMAIL, password: CORRECT_PASS)
    @wait.until { @browser.find_element(:xpath, "//a[.='Logout']").displayed? }
    @browser.find_element(:xpath, "//a[.='Logout']").click
    close_page
    @browser = Selenium::WebDriver.for @browser_type
    @browser.navigate.to('http://demoapp.strongqa.com/')
    test_result_evaluate(condition: @browser.find_element(:xpath, "//a[.='Login']"),
                         method: __method__)
    reset_cookies
  end

  def close_page
    @browser.quit
  end
end
