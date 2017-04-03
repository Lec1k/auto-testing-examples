Bundler.require(:test)
require_relative '../utils/app_logger'

class Login < SitePrism::Page
  element :email_field, '#user_email'
  element :password_field, '#user_password'
  element :remember_me, '#user_remember_me'
  element :flash_alert, '#flash_alert'

  set_url '/users/sign_in'

  def initialize
    super
    load
  end

  def log_in(email, password, *remember)
    AppLogger.log.debug("Action: Login with email:#{email}, password: #{password},"\
                       "remember me: #{remember.first}")
    email_field.set(email)
    password_field.set(password)
    remember_me.click if remember.first
    click_on('Log in')
    has_flash_alert? ? self : Home.new
  end

  def login_failed?
    AppLogger.log.debug('Action: Check if login failed')
    flash_alert.text == 'Invalid email or password.'
  end
end
