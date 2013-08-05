class SkiBinding::Person
  attr_reader :type, :weight, :height, :shoe_size, :age
  
  def initialize(values_hash)
    @type   = validate_type(values_hash["type"] || values_hash[:type])
    @weight =  values_hash["weight"] || values_hash[:weight]
    @height =  values_hash["height"] || values_hash[:height]
    @shoe_size =  values_hash["shoe_size"] || values_hash[:shoe_size]
    @age =  values_hash["age"] || values_hash[:age]
  end
  
  private

    def validate_type(type)
      types = {"Type1-" => -1, "Type1" => 0, "Type2" => 1, 
               "Type3" => 2, "Type3+" => 3}
      keys = types.keys
      types[type] if keys.include?(type)
    end
end
