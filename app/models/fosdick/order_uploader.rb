class Fosdick::OrderUploader
  def upload_orders
    exporter = Fosdick::OrderExporter.new(orders)
    uploader = Fosdick::FileUploader.new(
        host: Fosdick.config.ftp_host,
        username: Fosdick.config.username,
        password: Fosdick.config.password
    )

    exporter.export
    uploader.upload(exporter.header_path, exporter.details_path)
  end

  private

  def orders
    Spree::Order.complete.limit(10)
  end
end
