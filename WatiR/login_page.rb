class LoginPage
  attr_accessor :browser

  CORRECT_EMAIL = 'lec1k2103@gmail.com'.freeze
  CORRECT_PASS = 'testtest'.freeze
  INCORRECT_EMAIL = 'test@test.com'.freeze
  INCORRECT_PASS = 'qwertqwer'.freeze

  def initialize(browser:)
    @browser = browser
    @browser_type = @browser.name
  end

  private

  def login_navigation
    @browser.goto('http://demoapp.strongqa.com/')
    @browser.li(text: 'Login').click
  end

  def login_with_credentials(*is_remember, login:, password:)
    @browser.text_field(id: 'user_email').value = login
    @browser.text_field(id: 'user_password').value = password
    @browser.checkbox(id: 'user_remember_me').set unless is_remember.empty?
    @browser.execute_script("document.
                              getElementsByClassName('checkbox')[0].remove()")
    @browser.button(value: 'Log in').click
  end

  def login_fail?
    @browser.div(id: 'flash_alert').text == 'Invalid email or password.'
  end

  def login_success?
    @browser.div(id: 'flash_notice').text == 'Signed in successfully.'
  end

  def reset_cookies
    @browser.cookies.clear
  end

  def test_result_evaluate(condition:, method:)
    if condition
      puts "#{@browser_type}: #{method} is PASSED"
    else
      puts "#{@browser_type}: #{method} is FAILED"
    end
  end

  public

  def login_navigation_test
    login_navigation
    @browser.form(id: 'new_user').wait_until_present(timeout: 1)
    # Another possible condition @browser.url.include?("sign_in")
    test_result_evaluate(condition: @browser.form(id: 'new_user').exists?, method: __method__)
  end

  def correct_credentials_test
    login_navigation
    login_with_credentials(login: CORRECT_EMAIL, password: CORRECT_PASS)
    test_result_evaluate(condition: login_success?, method: __method__)
    reset_cookies
  end

  def login_remembering_test
    login_navigation
    login_with_credentials(true, login: CORRECT_EMAIL, password: CORRECT_PASS)
    test_result_evaluate(condition: login_success?, method: __method__)
    reset_cookies
  end

  def login_remembering_reopen_test
    login_navigation
    login_with_credentials(true, login: CORRECT_EMAIL, password: CORRECT_PASS)
    file_with_cookies = File.new('cookies.tmp', 'w')
    @browser.cookies.save(file_with_cookies)
    close_page
    @browser = Watir::Browser.new @browser_type
    login_navigation
    @browser.cookies.load(file_with_cookies)
    login_navigation
    @browser.a(text: 'Logout').wait_until_present(timeout: 1)
    test_result_evaluate(condition: @browser.a(text: 'Logout').exists?, method: __method__)
    reset_cookies
  end

  def logout_test
    login_navigation
    login_with_credentials(login: CORRECT_EMAIL, password: CORRECT_PASS)
    @browser.a(text: 'Logout').click
    close_page
    @browser = Watir::Browser.new @browser_type
    @browser.goto('http://demoapp.strongqa.com/')
    test_result_evaluate(condition: @browser.li(text: 'Login').exists?, method: __method__)
    reset_cookies
  end

  def login_blank_pass_test
    login_navigation
    login_with_credentials(login: CORRECT_EMAIL, password: '')
    test_result_evaluate(condition: login_fail?, method: __method__)
    reset_cookies
  end

  def login_blank_mail_test
    login_navigation
    login_with_credentials(login: '', password: CORRECT_PASS)
    test_result_evaluate(condition: login_fail?, method: __method__)
    reset_cookies
  end

  def login_blank_fields_test
    login_navigation
    login_with_credentials(login: '', password: '')
    test_result_evaluate(condition: login_fail?, method: __method__)
    reset_cookies
  end

  def login_incorrect_mail_test
    login_navigation
    login_with_credentials(login: INCORRECT_EMAIL, password: CORRECT_PASS)
    test_result_evaluate(condition: login_fail?, method: __method__)
    reset_cookies
  end

  def login_incorrect_pass_test
    login_navigation
    login_with_credentials(login: CORRECT_EMAIL, password: INCORRECT_PASS)
    test_result_evaluate(condition: login_fail?, method: __method__)
    reset_cookies
  end

  def login_incorrect_data_test
    login_navigation
    login_with_credentials(login: INCORRECT_EMAIL, password: INCORRECT_PASS)
    test_result_evaluate(condition: login_fail?, method: __method__)
    reset_cookies
  end

  def close_page
    @browser.close
  end
end
