Bundler.require(:test)
require_relative '../utils/app_logger'

class Login < SitePrism::Page


  set_url '/users/sign_in'



end