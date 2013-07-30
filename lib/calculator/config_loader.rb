require 'yaml'

module ConfigLoader
  extend self

  def load_binding_codes
    criterias ||= parse_yml("binding_codes.yml")   
  end
  
  def load_binding_settings(code)
    indices ||= parse_yml("binding_settings.yml")   
  end

  private
    def file_path
      path ||= File.expand_path("../../../config", __FILE__)
    end
    
    def parse_yml(filename)
      YAML::load(File.open("#{file_path}/#{filename}"))
    end
end
