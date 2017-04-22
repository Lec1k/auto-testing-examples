Bundler.require(:test)

Dir[File.dirname(__FILE__) + '/../../model/*.rb'].each { |file| require file }

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.configure do |config|
  config.current_driver = :chrome
  config.app_host = 'http://demoapp.strongqa.com/'
end

After { Capybara.reset_sessions! }
