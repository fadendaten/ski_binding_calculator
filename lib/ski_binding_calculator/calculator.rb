require 'ski_binding_calculator/config_loader'

class SkiBinding::Calculator 
  extend SkiBinding::ConfigLoader
  
  def self.setting(attrs)
    attrs = self.prep_attributes(attrs)
    attrs = self.age(attrs)
    attrs = self.validate_type(attrs)
    code = self.binding_code(attrs)
    self.binding_setting(attrs, code)
  end
  
  private
    def self.prep_attributes(attrs)
      hashy = {}
      hashy[:weight] = attrs[:weight].to_f || attrs["weight"].to_f
      hashy[:height] = attrs[:height].to_f || attrs["height"].to_f
      hashy[:shoe_size] = attrs[:shoe_size].to_f || attrs["shoe_size"].to_f
      hashy[:birthday] = attrs[:birthday] || attrs["birthdate"]
      hashy[:type] = attrs[:type] || attrs["type"]
      attrs = hashy
      attrs
    end
    
    def self.age(attrs)
      birthday = Date.parse(attrs[:birthday])
      now = Date.today
      age = now.year - birthday.year
      age -= ((now.month > birthday.month || 
             (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
      attrs.delete(:birthday)
      attrs[:age] = age
      attrs
    end
    
    def self.validate_type(attrs)
      type_string = attrs[:type]
      types = {"Type1-" => -1, "Type1" => 0, "Type2" => 1, 
               "Type3" => 2, "Type3+" => 3}
      keys = types.keys
      attrs[:type] = types[type_string] if keys.include?(type_string)
      attrs
    end
      
    def self.binding_code(attrs)
      code = -1
      self.load_binding_codes.each_with_index do |c,i|
        code = i
        break if c.weight.include?(attrs[:weight]) || 
                 c.height.include?(attrs[:height])
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
        if s.shoe_size_range.include?(attrs[:shoe_size])
          return {"z_value" => s.z_value}
        end
      end
    end
end
