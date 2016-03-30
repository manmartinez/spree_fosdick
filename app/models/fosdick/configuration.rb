class Fosdick::Configuration < Spree::Preferences::Configuration
  preference :file_prefix, :string
  preference :file_timezone, :string, default: "Eastern Time (US & Canada)"
  preference :export_path, :string, default: Rails.root.join('tmp').to_s
  preference :ad_code, :string
  preference :ftp_username, :string
  preference :ftp_host, :string
  preference :ftp_password, :string
  preference :ftp_upload_path, :string, default: "/in"
  preference :sequence_number, :integer, default: 1

  def increment_sequence_number!
    self.sequence_number += 1
  end
end
