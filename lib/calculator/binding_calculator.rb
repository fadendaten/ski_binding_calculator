require 'calculator/config_loader'

class BindingCalculator 
  include ConfigLoader
  
  def setting(person)
    @person = person
    binding_code
    binding_setting
  end
  
  private
    def binding_code 
      @code = -1
      self.load_binding_codes.each_with_index do |c,i|
        @code = i
        break if c.weight.include?(@person.weight) || c.height.include?(@person.height)
      end
      unless @person.weight < 13
        @code += @person.type
        if @person.age >= 50 || @person.age < 10
          @code -= 1
        end
      end
      @code
    end
  
    def binding_setting
      settings = load_binding_settings(@code)
      settings.each do |s|
        @setting = {"z_value" => s.z_value, 
                    "turning_moment" => s.turning_moment, 
                    "forward_pressure" => s.forward_pressure}
        break if s.range.include?(@person.shoe_size)
      end
      @setting
    end
end
