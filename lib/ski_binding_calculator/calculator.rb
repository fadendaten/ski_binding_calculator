require 'ski_binding_calculator/config_loader'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/object/blank'

class SkiBinding::Calculator 
  extend SkiBinding::ConfigLoader
  
  def self.setting(attrs)
    self.validate_attrs(attrs)
    attrs = self.prep_attributes(attrs)
    attrs = self.age(attrs)
    attrs = self.validate_type(attrs)
    code = self.binding_code(attrs)
    self.binding_setting(attrs, code)
  end
  
  private
    def self.validate_attrs(attrs)
      attrs = attrs.with_indifferent_access
      error = SkiBinding::Error.new
      attributes = [:weight, :height, :birthday_year, :birthday_month, :birthday_day, 
                    :sole_length, :type]
                    
      attributes.each do |attr|
        error.add_message(*[attr, "is blank"]) if attrs[attr].blank?
      end
      
      raise error unless error.messages.empty?
    end
    
    def self.prep_attributes(attrs)
      attrs = attrs.with_indifferent_access
      hashy = {}
      hashy[:weight] = attrs[:weight].to_f
      if hashy[:weight] < 10.0
        raise SkiBinding::Error.new(*[:weight, "is less than 10kg"])
      end
      hashy[:height] = attrs[:height].to_f
      if hashy[:height] <= 0.0
        raise SkiBinding::Error.new(*[:height, "must be bigger than 0"])
      end
      hashy[:sole_length] = attrs[:sole_length].to_f
      if hashy[:sole_length] <= 0.0
        raise SkiBinding::Error.new(*[:sole_length, "must be bigger than 0"])
      end 
      hashy[:birthday_year] = attrs[:birthday_year].to_i 
      hashy[:birthday_month] = attrs[:birthday_month].to_i 
      hashy[:birthday_day] = attrs[:birthday_day].to_i
      hashy[:type] = attrs[:type]
      hashy
    end
    
    def self.age(attrs)
      birthday = Date.new(attrs[:birthday_year], attrs[:birthday_month], attrs[:birthday_day])
      now = Date.today
      age = now.year - birthday.year
      age -= ((now.month > birthday.month || 
             (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
      attrs.delete(:birthday_year)
      attrs.delete(:birthday_month)
      attrs.delete(:birthday_day)
      attrs[:age] = age
      attrs
    end
    
    def self.validate_type(attrs)
      type_string = attrs[:type]
      types = {"Type1-" => -1, "Type1" => 0, "Type2" => 1, 
               "Type3" => 2, "Type3+" => 3}
      keys = types.keys
      if keys.include?(type_string)
        attrs[:type] = types[type_string]
      else
        raise SkiBinding::Error.new(*[:type, "You have entered an invalid type."])
      end
      attrs
    end
      
    def self.binding_code(attrs)
      code = -1
      self.load_binding_codes.each_with_index do |c,i|
        if c.height.nil?
          if c.weight.include?(attrs[:weight])
            code = i
            break
          end
        else
          if c.weight.include?(attrs[:weight]) || c.height.include?(attrs[:height])
            code = i
            break
          end
        end
      end
      if code == -1 
        raise SkiBinding::Error.new(*[:base, "You have entered invalid weight and/or height"])
      end
      unless attrs[:weight] < 13
        code += attrs[:type]
        if attrs[:age] >= 50 || attrs[:age] < 10
          code -= 1
        end
      end
      code
    end
    
    def self.binding_setting(attrs, code)
      settings = self.load_binding_settings(code)
      settings.each do |s|
        if s.sole_length_range.include?(attrs[:sole_length])
          unless s.z_value.nil?
            return {:z_value => s.z_value}
          else
            raise SkiBinding::Error.new(*[:base, "Please calculate z-index by hand."])
          end
        end
      end
    end
end
