class Index
  attr_reader :index, :size, :z_value, :mz, :my

  def initialize(index, hash)
    @index = index
    @size = hash.keys.first
    hash = hash[@size]
    @z_value = hash["z_value"] || hash[:z_value]
    @mz = hash["mz"] || hash[:mz]
    @my = hash["my"] || hash[:my]
  end

end
