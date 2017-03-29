Bundler.require(:test)
require_relative '../utils/app_logger'
require_relative 'login'

class Home < SitePrism::Page

  set_url '/'

  def navigate_to_login_page
    AppLogger.log.info('Navigating to login page')
    login_page = Login.new
    login_page.load
    login_page
  end
end