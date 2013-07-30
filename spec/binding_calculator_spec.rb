require 'spec_helper'

describe BindingCalculator do
  before(:all) do
    @type = 2
    @weight = 16
    @height = 308
    @size = 192 
    @age = 30
    @calculator = BindingCalculator.new(@type, @weight, @height, @size, @age)
  end

  describe "new" do
    it "should return a BindingCalculator class" do
      BindingCalculator.new(@type, @weight, @height, @size, @age).class.should == BindingCalculator
    end
  end

  describe "config loader" do
    it "should responds to load_binding_codes" do
      @calculator.should respond_to :load_binding_codes
    end
  end

  describe "binding_codes" do
    it "should return a valid binding code" do
      @calculator.binding_code.should == 3
    end
    it "should not be 4" do
      @calculator.binding_code.should_not == 4
    end
  end

  describe "binding_setting" do
    it "should return a Hash" do
      @calculator.binding_code
      @calculator.binding_setting.class.should == Hash
    end

    it "should return a valid value" do
      @calculator.binding_code
      @calculator.binding_setting.should == {"z-value"=>1.75, "turning_moment"=>17, "forward_pressure"=>64}
    end
  end
end
