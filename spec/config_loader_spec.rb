require 'spec_helper'

describe "ConfigLoader" do 

  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(ConfigLoader)
  end

  describe "loading config" do
    it "should load a config file" do
      @dummy_class.criterias.class.should == Array
    end
  end

  describe "first element of the array" do
    it "should be a hash" do
      @dummy_class.criterias[0].class.should == Hash 
    end

    it "should not be a string" do
      @dummy_class.criterias[0].class.should_not == String
    end
  end
    
end

class DummyClass 
end 
