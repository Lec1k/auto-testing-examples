Bundler.require(:test)
require_relative '../utils/app_logger'
require_relative 'login'

# Represents Home page of application
class Home < SitePrism::Page
  element :flash_notice, '#flash_notice'
  element :logout_button, 'a', text: 'Logout'
  set_url '/'

  def navigate_to_login_page
    AppLogger.log.debug('Action: Navigate to login page')
    load
    click_on('Login')
    Login.new.load
  end

  def logout
    AppLogger.log.debug('Action: Logout')
    click_on('Logout')
  end

  def user_logged_in?
    AppLogger.log.debug('Action: Check if user logged in')
    has_logout_button?
  end
end
