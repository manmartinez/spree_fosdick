class Fosdick::OrderDecorator < SimpleDelegator
  extend Fosdick::TemplateMethods

  template_methods  :inbound_number, :card_number, :card_expiration,
                    :authorization_code, :authorization_date,
                    :operator_code, :delivery_method, :micr_number,
                    :check_number, :bank_name, :bank_city, :bank_account_type,
                    :filler_one, :filler_two, :filler_three, :filler_four,
                    :filler_five

  def product_id
    "THE_PRODUCT_ID"
  end

  def transaction_time
    completed_at.strftime("%H%M%S")
  end

  def transaction_date
    completed_at.strftime("%m%d%Y")
  end

  def card_type
    'Q'
  end

  def fosdick_flags
    "WEB"
  end

  def number_of_payments
    1
  end
end
