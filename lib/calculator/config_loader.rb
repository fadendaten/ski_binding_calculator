require 'yaml'

module ConfigLoader
  extend self

  def load_binding_codes
    binding_codes ||= parse_yml("binding_codes.yml")   
  end
  
  def load_binding_settings(code)
    binding_settings ||= parse_yml("binding_settings.yml")  
    binding_settings[code] 
  end

  private
    def file_path
      path ||= File.expand_path("../../../config", __FILE__)
    end
    
    def parse_yml(filename)
      YAML::load(File.open("#{file_path}/#{filename}"))
    end
end
