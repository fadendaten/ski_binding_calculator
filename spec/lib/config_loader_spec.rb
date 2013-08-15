require 'spec_helper'

# For original table with codes referred to in this tests see iso 11088 
# Table B.1
describe "ConfigLoader" do 
  subject(:dummy_class) { DummyClass.new.extend(SkiBinding::ConfigLoader) }

  describe "loading binding codes:" do
    it { dummy_class.load_binding_codes.class.should_not == nil }
    
    context "when loaded codes" do
      subject(:codes) { dummy_class.load_binding_codes }
      
      it{ codes.class.should == Array }
      it{ codes[0].class.should == SkiBinding::Code }
      it{ codes.size.should == 13 }
    end
  end
  
  describe "loading binding settings for all codes" do
    subject(:settings_all_codes) do
      settings = []
      (0..15).each { |i| settings << dummy_class.load_binding_settings(i) }
      settings
    end
    
    context "for each code" do
      it { settings_all_codes.each { |s| s.class.should == Array } }
      it { settings_all_codes.each { |s| s[0].class.should == SkiBinding::Setting } }
      it { settings_all_codes.each { |s| s.size.should == 8 } }
    end
  end
end

class DummyClass 
end