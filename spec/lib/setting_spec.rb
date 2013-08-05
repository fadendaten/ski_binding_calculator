require 'spec_helper'

describe SkiBinding::Setting do
  describe "#new" do
    it "should return a Setting class" do
      SkiBinding::Setting.new.class.should == SkiBinding::Setting
    end
  end
    
  context "instantiated Setting class" do
    before :all do
      @setting = SkiBinding::Setting.new
    end
    
    it "has attribute shoe_size_range" do
      @setting.should respond_to :shoe_size_range
    end
    
    it "has attribute z_value" do
      @setting.should respond_to :z_value
    end
    
    it "has attribute twist" do
      @setting.should respond_to :twist
    end
    
    it "has attribute forward_lean" do
      @setting.should respond_to :forward_lean
    end
  end
end
