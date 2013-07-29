class Criteria

  attr_reader :weight, :height

  def initialize(hash)
    @weight = hash["weight"] || hash[:weight]
    @height= hash["height"] || hash[:height]
  end

end
