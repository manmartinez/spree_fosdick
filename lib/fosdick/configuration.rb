class Fosdick::Configuration
  attr_accessor :file_prefix, :product_id, :file_timezone, :export_path
  attr_accessor :ftp_username, :ftp_host, :ftp_password, :ftp_upload_path

  def initialize
    self.export_path = Rails.root.join('tmp')
    self.file_timezone = "Eastern Time (US & Canada)"
    self.ftp_upload_path = "/in"
  end
end
