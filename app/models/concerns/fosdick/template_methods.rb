module Fosdick
  module TemplateMethods
    def template_methods(*method_names)
      method_names.each do |method_name|
        define_method method_name do
          nil
        end
      end
    end
  end
end
