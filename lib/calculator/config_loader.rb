require 'yaml'

module ConfigLoader
  extend self

  def criterias 
    criterias ||= parse_yml("criterias.yml")   
  end

  private

  def file_path
    path ||= File.expand_path("../../../config", __FILE__)
  end

  def parse_yml(filename)
    YAML::load(File.open("#{file_path}/#{filename}"))
  end
  
end
