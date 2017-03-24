module TestRun
  def self.run_test(page:)
    page.public_methods(false).each do |method|
      begin
        page.send(method) if method.to_s.include? 'test'
      rescue Selenium::WebDriver::Error::TimeOutError => e
        puts "#{page.browser.browser}: #{method} FAILED: #{e.message}"
      end
    end
    page.close_page
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
