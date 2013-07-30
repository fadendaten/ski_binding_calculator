require 'calculator/config_loader'

class BindingCalculator 
  include ConfigLoader

  attr_reader :z_value, :rotation, :pressure

  def initialize(type, weight, height, shoe_size, age)
    @type   = type
    @weight = weight
    @height = height 
    @shoe_size = shoe_size 
    @age = age
  end

  def code 
    code = -1
    self.criterias.each_with_index do |c,i|
      puts c
      code = i
      break if c.weight.include?(@weight) || c.height.include?(@height)
    end
    code + @type
    if @age >= 50 || @age < 10
      puts "i was here"
      code -1
    end
    code
  end

  def z_value
    self.indices.each do |i|
      return i.z_value if i.size.include?(@shoe_size)
    end
  end


end
