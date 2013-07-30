require 'calculator/config_loader'

class BindingCalculator 
  include ConfigLoader

  attr_reader :z_value, :turning_moment, :forwar_pressure

  def initialize(type, weight, height, shoe_size, age)
    @type   = type
    @weight = weight
    @height = height 
    @shoe_size = shoe_size 
    @age = age
  end
  
  def setting(person)
    code
    binding_values
  end

  def code 
    @code = -1
    self.load_binding_codes.each_with_index do |c,i|
      @code = i
      break if c.weight.include?(@weight) || c.height.include?(@height)
    end
    @code + @type
    if @age >= 50 || @age < 10
      @code -1
    end
    return @code
  end

  def binding_values
    
  end
end
