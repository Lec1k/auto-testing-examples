
class Web

  @@path_map = {
      '/users/sign_in': Login.new ,
      '/': Home.new
  }

  def self.current_page
    @@path_map[Capybara.current_session.current_path.to_sym]
  end

  def self.user_logged_in?
    @@path_map[:/].user_logged_in?
  end

  def self.login_failed?
    @@path_map[:'/users/sign_in'].login_failed?
  end

end