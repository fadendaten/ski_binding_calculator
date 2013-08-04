require 'spec_helper'

describe SkiBinding::Calculator do
  before(:all) do
    @calculator = SkiBinding::Calculator.new
    hash = {:type => "Type2", :weight => 70, 
            :height => 170, :shoe_size => 315, :age => 30}
    @person = SkiBinding::Person.new(hash)
  end

  describe "new" do
    it "returns a BindingCalculator class" do
      SkiBinding::Calculator.new.class.should == SkiBinding::Calculator
    end
  end
  
  describe "config loader" do
    it "responds to binding_settings" do
      SkiBinding::Calculator.should respond_to :setting
    end
    
    it "responds to binding_codes" do
      SkiBinding::Calculator.should respond_to :binding_code
    end
    
    it "responds to binding_settings" do
      SkiBinding::Calculator.should respond_to :binding_setting
    end
  end
  
  describe "#setting" do
    it "returns a valid setting" do
      SkiBinding::Calculator.setting(@person).should == 
      {"z_value"=>6, "turning_moment"=>58, "forward_pressure"=>229}
    end
  end
  
  describe "#binding_code" do
    it "returns a valid code" do
      SkiBinding::Calculator.binding_code(@person).should == 11
    end
    
    it "returns code one less than before if age >= 50" do
      hash = {:type => "Type2", :weight => 70, 
            :height => 170, :shoe_size => 315, :age => 50}
      @person = SkiBinding::Person.new(hash)
      SkiBinding::Calculator.binding_code(@person).should == 10
      hash[:age] = 51
      @person = SkiBinding::Person.new(hash)
      SkiBinding::Calculator.binding_code(@person).should == 10
    end
    
    it "returns code unchanged if weight less than 13kg" do
      hash = {:type => "Type2", :weight => 12, 
            :height => 147, :shoe_size => 249, :age => 30}
      @person = SkiBinding::Person.new(hash)
      SkiBinding::Calculator.binding_code(@person).should == 0
    end
  end
  
  describe "#binding_setting" do
    it "returns a valid setting" do
      SkiBinding::Calculator.binding_setting(11, @person).should == 
      {"z_value"=>6, "turning_moment"=>58, "forward_pressure"=>229}
    end
  end
end
