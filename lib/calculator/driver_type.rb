class DriverType
  attr_reader :name, :moving_value

  def initialize(name, moving_value)
    @name = name
    @moving_value = moving_value
  end

end
