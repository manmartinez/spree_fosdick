module Fosdick
  def self.config
    @config ||= Fosdick::Configuration.new
  end

  def self.configure
    yield config
  end
end
