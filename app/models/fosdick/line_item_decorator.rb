class Fosdick::LineItemDecorator < SimpleDelegator
  extend Fosdick::TemplateMethods

  template_methods :handling_charge, :ship_separately_flag,
                   :first_installment_flag, :filler_one,
                   :filler_two, :filler_three, :filler_four,
                   :filler_five, :filler_six, :filler_seven
end
