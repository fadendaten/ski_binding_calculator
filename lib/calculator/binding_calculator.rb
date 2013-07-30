require 'calculator/config_loader'

class BindingCalculator 
  include ConfigLoader

  def initialize(type, weight, height, shoe_size, age)
    @type   = type
    @weight = weight
    @height = height 
    @shoe_size = shoe_size 
    @age = age
  end
  
  def setting(person)
    binding_code
    binding_values
  end

  def binding_code 
    @code = -1
    self.load_binding_codes.each_with_index do |c,i|
      @code = i
      break if c.weight.include?(@weight) || c.height.include?(@height)
    end
    @code += @type
    if @age >= 50 || @age < 10
      @code -= 1
    end
    @code
  end

  def binding_setting
    settings = load_binding_settings(@code)
    settings.each do |s|
      @setting = {"z-value" => s.z_value, 
                  "turning_moment" => s.turning_moment, 
                  "forward_pressure" => s.forward_pressure}
      break if s.range.include?(@shoe_size)
    end
    @setting
  end
end
