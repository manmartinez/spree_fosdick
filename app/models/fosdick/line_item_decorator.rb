class Fosdick::LineItemDecorator < SimpleDelegator
  extend Fosdick::TemplateMethods

  template_methods :handling_charge, :ship_separately_flag,
                   :first_installment_flag
end
