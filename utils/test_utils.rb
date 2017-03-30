require_relative('app_logger')
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
        AppLogger.log.error(e.message + e.backtrace)
      ensure
        Capybara.reset_sessions!
      end
    end
  end

  def self.watir_run_test(page:)
    page.public_methods(false).each do |method|
      begin
        page.send(method) if method.to_s.include? 'test'
      rescue Watir::Wait::TimeoutError => e
        puts "#{page.browser.name}: #{method} FAILED: #{e.message}"
      end
    end
    page.close_page
  end
end
