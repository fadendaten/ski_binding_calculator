require 'spec_helper'

describe "ConfigLoader" do 

  before(:all) do
    @range = 0..15 #cause 16 settings
    @dummy_class = DummyClass.new
    @dummy_class.extend(SkiBinding::ConfigLoader)
  end

  describe "loading binding codes:" do
    it "something gets loaded" do
      @dummy_class.load_binding_codes.class.should_not == nil
    end
    
    context "loaded codes" do
      before :all do
        @codes = @dummy_class.load_binding_codes
      end
      
      it "is array" do
        @codes.class.should == Array
      end
      
      it "first element is code" do
        @codes[0].class.should == SkiBinding::Code
      end
      
      it "has 15 codes" do
        @codes.size.should == 13
      end
    end
  end
  
  describe "loading binding settings for all codes" do
    it "something gets loaded" do
      @range.each do |index|
        @dummy_class.load_binding_settings(index).class.should_not == nil
      end
    end
    
    context "loaded settings for each code" do
      before :all do
        @settings_all_codes = []
        @range.each do |index|
          @settings_all_codes << @dummy_class.load_binding_settings(index)
        end
      end
      
      it "is array" do
        @settings_all_codes.each do |s|
          s.class.should == Array
        end
      end
      
      it "first element is setting" do
        @settings_all_codes.each do |s|
          s[0].class.should == SkiBinding::Setting
        end
      end
      
      it "has 6 settings" do
        @settings_all_codes.each do |s|
         s.size.should == 8
        end
      end
    end
  end
end

class DummyClass 
end