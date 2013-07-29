require 'yaml'

module ConfigLoader
  extend self

  def criterias 
    criterias = []
    load_criterias.each do |c|
      criterias << Criteria.new(c)
    end
    criterias
  end

  def indices 
    indices = []
    load_indices.each do |code|
      code[1].each do |v|
        indices << Index.new(code[0], v)
      end
    end
    indices 
  end

  def load_indices
    indices ||= parse_yml("indices.yml")   
  end


  def load_criterias
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
