require "payloader/engine"
require "payloader/config"

module Payloader
  def self.config
    @config = Config.new
  end

  def self.configure
    yield if block_given?
  end
end
