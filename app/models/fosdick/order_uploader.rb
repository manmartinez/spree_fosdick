class Fosdick::OrderUploader
  def upload_orders
    exporter = Fosdick::OrderExporter.new(orders)
    uploader = Fosdick::FileUploader.new(
        host: Fosdick.config.ftp_host,
        username: Fosdick.config.ftp_username,
        password: Fosdick.config.ftp_password,
        upload_path: Fosdick.config.ftp_upload_path
    )

    exporter.export
    uploader.upload(exporter.header_path, exporter.details_path)
  end

  private

  def orders
    Spree::Order.complete.limit(10)
  end
end
