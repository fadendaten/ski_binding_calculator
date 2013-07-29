require 'spec_helper'

describe BindingCalculator do
  before(:each) do
    @type = DriverType.new("2",2)
    @weight = 16
    @height = 308
    @size = 192 
    @calculator = BindingCalculator.new(@type, @weight, @height, @size)
  end

  describe "new" do
    it "should return a BindingCalculator class" do
      BindingCalculator.new(@type, @weight, @height, @size).class.should == BindingCalculator
    end
  end

  describe "config laoder" do
    it "should responds to criterias" do
      @calculator.should respond_to :criterias
    end
    it "should responds to load_criterias" do
      @calculator.should respond_to :load_criterias
    end
  end

  describe "code" do
    it "should return a valid code" do
      @calculator.code.should == 3
    end
    it "should not be 4" do
      @calculator.code.should_not == 4
    end
  end

  describe "z_value" do
    it "should return a Float" do
      @calculator.z_value.class.should == Float
    end

    it "should return a valid value" do
      @calculator.z_value.should == 0.75
    end
  end


end
