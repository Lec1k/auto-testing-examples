Bundler.require(:test)
require_relative '../utils/app_logger'
require_relative 'home'
require_relative 'login'

class AppTests


  def test_app
    AppLogger.log.info('Testing started')
    @home_page = Home.new
    @home_page.load
    @login_page = @home_page.navigate_to_login_page

  end

end