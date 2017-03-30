Bundler.require(:test)
require_relative '../utils/app_logger'
require_relative 'login'

class Home < SitePrism::Page
  element :flash_notice, '#flash_notice'
  element :logout_button, 'a', text: 'Logout'
  set_url '/'

  def initialize
    super
    load
  end

  def navigate_to_login_page
    AppLogger.log.debug('Action: Navigate to login page')
    click_on('Login')
    login_page = Login.new
    login_page
  end

  def logout
    AppLogger.log.debug('Action: Logout')
    click_on('Logout')
    page = Home.new
    page.load
    page
  end

  def user_logged_in?
    AppLogger.log.debug('Action: Check if user logged in')
    has_flash_notice? || has_logout_button?
  end
end
