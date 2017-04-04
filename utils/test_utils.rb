require_relative('app_logger')
# Module contains methods for running tests
module TestRun
  def self.run_test(test)
    test.public_methods(false).each do |method|
      begin
        test.send(method) if method.to_s.include? 'test'
      rescue Capybara::ElementNotFound => e
        AppLogger.log.error "#{method} FAILED: #{e.message}"
      rescue Selenium::WebDriver::Error => e
        AppLogger.log.error(e)
      rescue => e
        AppLogger.log.error(e)
      ensure
        Capybara.reset_sessions!
      end
    end
  end
end
