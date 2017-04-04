Bundler.require(:test)
require_relative '../utils/app_logger'

# Represents Login page in application
class Login < SitePrism::Page
  element :email_field, '#user_email'
  element :password_field, '#user_password'
  element :remember_me, '#user_remember_me'
  element :login_button, 'input.button.right'
  element :flash_alert, '#flash_alert'

  set_url '/users/sign_in'

  def log_in(email, password, *remember)
    AppLogger.log.debug("Action: Login with email:#{email}, password: #{password},"\
                       "remember me: #{!remember.empty?}")
    email_field.set(email)
    password_field.set(password)
    remember_me.click unless remember.empty?
    login_button.click
  end

  def login_failed?
    AppLogger.log.debug('Action: Check if login failed')
    flash_alert.text == 'Invalid email or password.'
  end
end
