class SkiBinding::Person
  include ConfigLoader
  
  attr_reader :type, :weight, :height, :shoe_size, :age
  
  def initialize(hash)
    @type   = validate_type(hash["type"] || hash[:type])
    @weight =  hash["weight"] || hash[:weight]
    @height =  hash["height"] || hash[:height]
    @shoe_size =  hash["shoe_size"] || hash[:shoe_size]
    @age =  hash["age"] || hash[:age]
  end
  
  private

    def validate_type(type)
      types = {"Type1-" => -1, "Type1" => 0, "Type2" => 1, 
               "Type3" => 2, "Type3+" => 3}
      keys = types.keys
      types[type] if keys.include?(type)
    end
end
