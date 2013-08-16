class SkiBinding::Error < StandardError
  
  def initialize
    @messages = {}
  end
  
  def messages
    @messages
  end
  
  def add_message(key, value)
    @messages[key] = value
  end
end