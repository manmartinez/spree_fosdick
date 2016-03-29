class Fosdick::OrderUploader
  def initialize(orders)
    @orders = orders
  end

  def upload
    exporter.export
    uploader.upload(exporter.header_path, exporter.details_path)
  end

  private

  attr_reader :orders

  def exporter
    @exporter ||= Fosdick::OrderExporter.new(orders)
  end

  def uploader
    @uploader ||= Fosdick::FileUploader.new(
      host: Fosdick.config.ftp_host,
      username: Fosdick.config.ftp_username,
      password: Fosdick.config.ftp_password,
      upload_path: Fosdick.config.ftp_upload_path
    )
  end
end
