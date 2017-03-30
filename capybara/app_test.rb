Bundler.require(:test)
require_relative '../utils/app_logger'
require_relative 'home'
require_relative 'login'

class AppTest
  CORRECT_EMAIL = 'lec1k2103@gmail.com'.freeze
  CORRECT_PASS = 'testtest'.freeze
  INCORRECT_EMAIL = 'test@test.com'.freeze
  INCORRECT_PASS = 'qwertqwer'.freeze

  def initialize
    @current_page = Home.new
  end

  def login_navigation_test
    AppLogger.log.info('TC: User can open login page via menu')
    @current_page = Home.new
    @current_page = @current_page.navigate_to_login_page
    if @current_page.is_a? Login
      AppLogger.log.info('[PASS] user is redirected to login page')
    else
      AppLogger.log.info("[FAIL] user is not redirected to login page,
       current page is #{@current_page.class}")
    end
  end

  def correct_credentials_test
    AppLogger.log.info('TC: User can login with correct credentials')
    @current_page = Home.new.navigate_to_login_page
    @current_page = @current_page.log_in(CORRECT_EMAIL, CORRECT_PASS)

    if @current_page.is_a? Home
      AppLogger.log.info('[PASS] User is redirected to Home page')
      if @current_page.user_logged_in?
        AppLogger.log.info('[PASS] User is logged in')
      else
        AppLogger.log.info('[FAIL] User is failed to log in')
      end
    else
      AppLogger.log.info('[FAIL] User is not redirected to Home page,'\
                         "current page is #{@current_page.class}")
    end
  end

  def remember_credentials_test
    AppLogger.log.info('TC: User can login with remembering credentials')
    @current_page = Home.new.navigate_to_login_page
    @current_page = @current_page.log_in(CORRECT_EMAIL, CORRECT_PASS, true)
    if @current_page.is_a? Home
      AppLogger.log.info('[PASS] User is redirected to Home page')
      if @current_page.user_logged_in?
        AppLogger.log.info('[PASS] User is logged in')
      else
        AppLogger.log.info('[FAIL] User is failed to log in')
      end
    else
      AppLogger.log.info('[FAIL] User is not redirected to Home page,'\
                         "current page is #{@current_page.class}")
    end
  end

  def logout_test
    AppLogger.log.info("TC: User shouldn't be logged to the system after logout")
    @current_page = Home.new.navigate_to_login_page
    @current_page = @current_page.log_in(CORRECT_EMAIL, CORRECT_PASS, true)
    @current_page = @current_page.logout
    if @current_page.user_logged_in?
      AppLogger.log.info('[FAIL] User is expected to be logged out')
    else
      AppLogger.log.info('[PASS] User is logged out')
    end
  end

  def blank_password_test
    AppLogger.log.info('TC: User can not login with blank password')
    @current_page = Home.new.navigate_to_login_page
    @current_page = @current_page.log_in(CORRECT_EMAIL, '', true)
    if @current_page.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.info('[FAIL] User is logged in')
    end
  end

  def blank_email_test
    AppLogger.log.info('TC: User can not login with blank email')
    @current_page = Home.new.navigate_to_login_page
    @current_page = @current_page.log_in('', CORRECT_PASS, true)
    if @current_page.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.info('[FAIL] User is logged in')
    end
  end

  def blank_data_test
    AppLogger.log.info('TC: User can not login with blank fields')
    @current_page = Home.new.navigate_to_login_page
    @current_page = @current_page.log_in('', '', true)
    if @current_page.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.info('[FAIL] User is logged in')
    end
  end

  def incorrect_email_test
    AppLogger.log.info('TC: User can not login with incorrect email')
    @current_page = Home.new.navigate_to_login_page
    @current_page = @current_page.log_in(INCORRECT_EMAIL, CORRECT_PASS, true)
    if @current_page.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.info('[FAIL] User is logged in')
    end
  end

  def incorrect_password_test
    AppLogger.log.info('TC: User can not login with incorrect password')
    @current_page = Home.new.navigate_to_login_page
    @current_page = @current_page.log_in(CORRECT_EMAIL, INCORRECT_PASS, true)
    if @current_page.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.info('[FAIL] User is logged in')
    end
  end

  def incorrect_data_test
    AppLogger.log.info('TC: User can not login with incorrect data')
    @current_page = Home.new.navigate_to_login_page
    @current_page = @current_page.log_in(INCORRECT_EMAIL, INCORRECT_PASS, true)
    if @current_page.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.info('[FAIL] User is logged in')
    end
  end
end
