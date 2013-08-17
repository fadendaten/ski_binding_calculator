class SkiBinding::Error < StandardError 
  def initialize(key = nil, value = nil)
    @messages = {}
    
    if !key.nil? && !value.nil?
      @messages[key] = value
    end
  end
  
  def messages
    @messages
  end
  
  def add_message(key, value)
    @messages[key] = value
  end
end