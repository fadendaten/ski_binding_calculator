require 'ski_binding_calculator/config_loader'

class SkiBinding::Calculator 
  extend SkiBinding::ConfigLoader
  
  def self.setting(person)
    code = self.binding_code(person)
    self.binding_setting(code, person)
  end
  
  private
  
    def self.binding_code(person)
      code = -1
      self.load_binding_codes.each_with_index do |c,i|
        code = i
        break if c.weight.include?(person.weight) || 
                 c.height.include?(person.height)
      end
      unless person.weight < 13
        code += person.type
        if person.age >= 50 || person.age < 10
          code -= 1
        end
      end
      code
    end
  
    def self.binding_setting(code, person)
      settings = self.load_binding_settings(code)
      settings.each do |s|
        if s.shoe_size_range.include?(person.shoe_size)
          return {"z_value" => s.z_value, 
                  "twist" => s.twist, 
                  "forward_lean" => s.forward_lean}
        end
      end
    end
end
