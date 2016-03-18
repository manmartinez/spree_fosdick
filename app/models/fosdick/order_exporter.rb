class Fosdick::OrderExporter
  def initialize(orders, path: default_path)
    @orders = orders
    @path = path
  end

  def export
    begin
      export_orders
      add_trailer_records
    ensure
      header_file.close
      details_file.close
    end
  end

  def header_path
    @header_path ||= generate_path('h')
  end

  def details_path
    @details_path ||= generate_path('d')
  end

  private

  attr_reader :path, :orders

  def export_orders
    orders.each do |order|
      export_order(order)
    end
  end

  def export_order(order)
    header_file << order_fields(order)
    order.line_items.each_with_index do |line_item, index|
      details_file << line_item_fields(order, line_item, index)
    end
  end

  def add_trailer_records
    header_file << trailer_record_fields(
      filename: generate_filename('h'),
      row_count: header_file.lineno + 1
    )

    details_file << trailer_record_fields(
      filename: generate_filename('d'),
      row_count: details_file.lineno + 1
    )
  end

  def trailer_record_fields(filename:, row_count:)
    [
      "TRAILER RECORD", filename, date_string, time_string,
      row_count, sequence_number
    ]
  end

  def order_fields(spree_order)
    order = Fosdick::OrderDecorator.new(spree_order)
    [
      order.number, address_fields(order.bill_address), order.bill_address.phone,
      order.card_type, order.card_number, order.card_expiration,
      order.authorization_code, order.authorization_date, order.fosdick_flags,
      product_id, order.inbound_number, order.transaction_time,
      order.transaction_date, order.operator_code,
      address_fields(order.ship_address), order.number_of_payments,
      order.delivery_method, order.item_total, order.ship_total,
      order.tax_total, order.promo_total, order.total,
      order.email, order.micr_number, order.check_number,
      order.bank_name, order.bank_city, order.ship_address.phone,
      order.bank_account_type, order.filler_one, order.filler_two,
      order.filler_three, order.filler_four, order.filler_five
    ].flatten
  end

  def address_fields(spree_address)
    address = Fosdick::AddressDecorator.new(spree_address)
    [
      address.firstname, address.lastname, address.address1,
      address.address2, address.address3, address.city,
      address.state_text, address.zipcode, address.country_text
    ]
  end

  def line_item_fields(order, spree_line_item, index)
    line_item = Fosdick::LineItemDecorator.new(spree_line_item)
    [
      order.number, index + 1, line_item.sku, line_item.quantity,
      line_item.price, line_item.handling_charge,
      line_item.ship_separately_flag, line_item.first_installment_flag,
      line_item.filler_one, line_item.filler_two, line_item.filler_three,
      line_item.filler_four, line_item.filler_five, line_item.filler_six,
      line_item.filler_seven
    ]
  end

  def product_id
    Fosdick.config.product_id
  end

  def details_file
    @details_file ||= CSV.open details_path, 'wb', csv_options
  end

  def header_file
    @header_file ||= CSV.open header_path, 'wb', csv_options
  end

  def csv_options
    { col_sep: "\t" }
  end

  def generate_path(file_type)
    File.join path, generate_filename(file_type)
  end

  def generate_filename(file_type)
    [file_prefix, file_type, date_string, '-', sequence_number, '.csv'].join
  end

  def file_prefix
    Fosdick.config.file_prefix
  end

  def sequence_number
    "00001"
  end

  def date_string
    @date_string ||= current_time.strftime("%Y%m%d")
  end

  def time_string
    @time_string ||= current_time.strftime("%H%M%S")
  end

  def current_time
    Time.current.in_time_zone Fosdick.config.file_timezone
  end

  def default_path
    Fosdick.config.export_path
  end
end
