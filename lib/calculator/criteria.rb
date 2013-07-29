class Criteria

  attr_reader :weight, :size

  def initialize(hash)
    @weight = hash[:weight]
    @size = hash[:size]
  end

end
