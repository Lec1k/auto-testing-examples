require 'logger'

class AppLogger
  def self.log
    if @logger.nil?
      @logger = Logger.new STDOUT
      @logger.level = Logger::DEBUG
      @logger.datetime_format = '%m-%d-%Y %H:%M:%S '
    end
    @logger
  end
end