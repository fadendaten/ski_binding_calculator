require 'spec_helper'

# For original table with codes referred to in this tests see iso 11088 
# table B.1
describe "ConfigLoader" do 
  subject(:dummy_class) { double('empty class').extend SkiBinding::ConfigLoader }

  describe "#load_binding_codes" do
    context "loaded binding codes" do
      let(:loaded_codes) { dummy_class.load_binding_codes }
      
      it{ expect(loaded_codes).to be_instance_of(Array)}
      it{ loaded_codes.should have(13).elements }
      it "first element is instance of SkiBinding::Code" do
        expect(loaded_codes[0]).to be_instance_of(SkiBinding::Code)
      end
    end
  end
  
  describe "#load_binding_setting" do
    let(:settings_all_codes) { (0..15).map { |i| dummy_class.load_binding_settings(i) } }
    
    context "for each code loaded settings" do
      it { settings_all_codes.each { |s| expect(s).to be_instance_of(Array) } }
      it { settings_all_codes.each { |s| s.should have(8).elements } }
      it "first element is instance of SkiBinding::Setting" do
        settings_all_codes.each { |s| expect(s[0]).to be_instance_of(SkiBinding::Setting) }
      end
    end
  end
end