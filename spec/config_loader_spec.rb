require 'spec_helper'

describe "ConfigLoader" do 

  before(:all) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(ConfigLoader)
  end

  describe "loading config" do
    it "should load a config file" do
      @dummy_class.load_binding_codes.class.should == Array
    end
  end

  describe "first element of the array" do
    it "should be a BindingCode" do
      @dummy_class.load_binding_codes[0].class.should == BindingCode
    end

    it "should not be a string" do
      @dummy_class.load_binding_codes[0].class.should_not == String
    end
  end
end

class DummyClass 
end