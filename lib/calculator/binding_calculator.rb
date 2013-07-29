require 'calculator/config_loader'

class BindingCalculator 
  include ConfigLoader

  attr_reader :z_value, :rotation, :pressure

  def initialize(type, weight, height, size)
    @type   = type
    @weight = weight
    @height = height 
    @size   = size 
  end

  def code 
    code = 0
    self.criterias.each_with_index do |c,i|
      code = i
      break if c.weight.include?(@weight) || c.height.include?(@height)
    end
    code + @type.moving_value
  end

  def z_value
    self.indices.each do |i|
      return i.z_value if i.size.include?(@size)
    end
  end


end
