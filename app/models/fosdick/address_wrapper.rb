class Fosdick::AddressWrapper < SimpleDelegator
  extend Fosdick::TemplateMethods

  template_methods :address3

  def country_text
    country.try(:iso3)
  end
end
