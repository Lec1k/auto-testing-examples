class LoginPage

  attr_accessor :browser

  def initialize(browser:)
    @browser = browser
  end

  private

  def login_navigation
    @browser.goto("http://demoapp.strongqa.com/")
    @browser.li(:text => "Login").click
  end

  def login_with_credentials(*is_remember, login:, password:)
    @browser.text_field(:id => 'user_email').value = login
    @browser.text_field(:id => 'user_password').value = password
    @browser.checkbox(:id => 'user_remember_me').set unless is_remember.empty?
    @browser.execute_script("document.getElementsByClassName('checkbox')[0].remove()")
    @browser.button(:value => 'Log in').click
  end

  public

  def login_navigation_test
    login_navigation
    @browser.form(:id => "new_user").wait_until_present(timeout: 1)
    if @browser.form(:id => "new_user").exists? && @browser.url.include?("sign_in")
      puts "Login navigation test PASSED"
    else
      puts "Login navigation test FAILED"
    end
  end

  def correct_credentials_test
    login_navigation
    login_with_credentials(login: 'lec1k2103@gmail.com', password: 'testtest')
    if @browser.url == "http://demoapp.strongqa.com/" && @browser.div(:id => 'flash_notice')
                                                             .text == 'Signed in successfully.'
      puts 'Correct credentials test PASSED'
    else
      puts 'Correct credentials test FAILED'
    end
  end

  def login_remembering_test
    login_navigation
    login_with_credentials(true,login: 'lec1k2103@gmail.com', password: 'testtest')
    if @browser.url == "http://demoapp.strongqa.com/" && @browser.div(:id => 'flash_notice')
                                                             .text == 'Signed in successfully.'
      puts 'Correct credentials test PASSED'
    else
      puts 'Correct credentials test FAILED'
    end
  end

  def login_remembering_reopen_test
    login_navigation
    login_with_credentials(true,login: 'lec1k2103@gmail.com', password: 'testtest')
    browser_type = @browser.name
    file_with_cookies = File.new('cookies.tmp','w')
    @browser.cookies.save(file_with_cookies)
    @browser.close
    @browser = Watir::Browser.new browser_type

    @browser.goto("http://demoapp.strongqa.com/")
    @browser.cookies.load(file_with_cookies)
    @browser.refresh
    sleep(10)
    if @browser.li(:text => "Login").exists?
      puts 'Login remembering reopen browser test FAILED'
    else
      puts 'Login remembering reopen browser test PASSED'
    end
  end

  def logout_test
    login_navigation
    login_with_credentials(login: 'lec1k2103@gmail.com', password: 'testtest')
    @browser.a(:text => 'Logout').click
    browser_type = @browser.name
    sleep(10)
    @browser.close
    @browser = Watir::Browser.new browser_type
    @browser.goto("http://demoapp.strongqa.com/")
  end

  def login_blank_pass_test
    login_navigation
    login_with_credentials(login: 'lec1k2103@gmail.com', password: '')


  end

  def login_blank_mail_test
    login_navigation
    login_with_credentials(login: '', password: 'testtest')

  end

  def login_blank_fields_test
    login_navigation
    login_with_credentials(login: '', password: '')

  end

end