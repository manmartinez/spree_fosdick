class Fosdick::Configuration
  attr_accessor :file_prefix, :product_id, :file_timezone

  def initialize
    self.file_timezone = "Eastern Time (US & Canada)"
  end
end
