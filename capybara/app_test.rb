require_relative '../utils/app_logger'
require_relative 'home'
require_relative 'login'
require_relative 'web'

# Aggregates all tests in one class
class AppTest < Web
  CORRECT_EMAIL = 'lec1k2103@gmail.com'.freeze
  CORRECT_PASS = 'testtest'.freeze
  INCORRECT_EMAIL = 'test@test.com'.freeze
  INCORRECT_PASS = 'qwertqwer'.freeze

  def login_navigation_test
    AppLogger.log.info('TC: User can open login page via menu')
    Home.new.navigate_to_login_page
    if Web.current_page.is_a? Login
      AppLogger.log.info('[PASS] user is redirected to login page')
    else
      AppLogger.log.error("[FAIL] user is not redirected to login page,
       current page is #{@current_page.class}")
    end
  end

  def correct_credentials_test
    AppLogger.log.info('TC: User can login with correct credentials')
    Home.new.navigate_to_login_page
    Login.new.log_in(CORRECT_EMAIL, CORRECT_PASS)

    unless Web.current_page.is_a? Home
      AppLogger.log.error('[FAIL] User is not redirected to Home page,'\
                         "current page is #{Web.current_page.class}")
      return
    end
    AppLogger.log.info('[PASS] User is redirected to Home page')
    if Web.user_logged_in?
      AppLogger.log.info('[PASS] User is logged in')
    else
      AppLogger.log.error('[FAIL] User is failed to log in')
    end
  end

  def remember_credentials_test
    AppLogger.log.info('TC: User can login with remembering credentials')
    Home.new.navigate_to_login_page
    Login.new.log_in(CORRECT_EMAIL, CORRECT_PASS, true)
    unless Web.current_page.is_a? Home
      AppLogger.log.error('[FAIL] User is not redirected to Home page,'\
                         "current page is #{Web.current_page.class}")
      return
    end
    AppLogger.log.info('[PASS] User is redirected to Home page')
    if Web.user_logged_in?
      AppLogger.log.info('[PASS] User is logged in')
    else
      AppLogger.log.error('[FAIL] User is failed to log in')
    end
  end

  def logout_test
    AppLogger.log.info("TC: User shouldn't be logged to the system after logout")
    Home.new.navigate_to_login_page
    Login.new.log_in(CORRECT_EMAIL, CORRECT_PASS, true)
    Home.new.logout
    if Web.user_logged_in?
      AppLogger.log.error('[FAIL] User is expected to be logged out')
    else
      AppLogger.log.info('[PASS] User is logged out')
    end
  end

  def blank_password_test
    AppLogger.log.info('TC: User can not login with blank password')
    Home.new.navigate_to_login_page
    Login.new.log_in(CORRECT_EMAIL, '', true)
    if Web.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.error('[FAIL] User is logged in')
    end
  end

  def blank_email_test
    AppLogger.log.info('TC: User can not login with blank email')
    Home.new.navigate_to_login_page
    Login.new.log_in('', CORRECT_PASS, true)
    if Web.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.error('[FAIL] User is logged in')
    end
  end

  def blank_data_test
    AppLogger.log.info('TC: User can not login with blank fields')
    Home.new.navigate_to_login_page
    Login.new.log_in('', '', true)
    if Web.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.error('[FAIL] User is logged in')
    end
  end

  def incorrect_email_test
    AppLogger.log.info('TC: User can not login with incorrect email')
    Home.new.navigate_to_login_page
    Login.new.log_in(INCORRECT_EMAIL, CORRECT_PASS, true)
    if Web.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.error('[FAIL] User is logged in')
    end
  end

  def incorrect_password_test
    AppLogger.log.info('TC: User can not login with incorrect password')
    Home.new.navigate_to_login_page
    Login.new.log_in(CORRECT_EMAIL, INCORRECT_PASS, true)
    if Web.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.error('[FAIL] User is logged in')
    end
  end

  def incorrect_data_test
    AppLogger.log.info('TC: User can not login with incorrect data')
    Home.new.navigate_to_login_page
    Login.new.log_in(INCORRECT_EMAIL, INCORRECT_PASS, true)
    if Web.login_failed?
      AppLogger.log.info('[PASS] User is not logged in and message: '\
                         '"Invalid email or password" appeared')
    else
      AppLogger.log.error('[FAIL] User is logged in')
    end
  end
end
