require 'spec_helper'

describe SkiBinding::Setting do
  describe "new" do
    it "should return a Setting class" do
      SkiBinding::Setting.new.class.should == SkiBinding::Setting
    end
  end
    
  context "instantiated Setting class" do
    before :all do
      @setting = SkiBinding::Setting.new
    end
    
    it "has attribute range" do
      @setting.should respond_to :range
    end
    
    it "has attribute z_value" do
      @setting.should respond_to :z_value
    end
    
    it "has attribute turning_moment" do
      @setting.should respond_to :turning_moment
    end
    
    it "has attribute forward_pressure" do
      @setting.should respond_to :forward_pressure
    end
  end
end
