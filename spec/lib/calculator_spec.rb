require 'spec_helper'
require 'timecop'

# The scenario: according to table B.1 in ISO 11088 a skier which is
# type 2, 70 kg of weight, 170cm of height, has a sole length of 
# 315mm, and is born 01/01/1983 has code "L" or in our notation 11 
# (see readme for details on codes). Furthermore it's z_value is 6.
describe SkiBinding::Calculator do
  subject(:skiers_parameters) do
    { :type => "Type2", 
     :weight => "70", 
     :height => "170", 
     :sole_length => "315", 
     :birthday_year => "1983",
     :birthday_month => "01",
     :birthday_day => "01" }  
  end
  subject(:skiers_parameters_string_keys) do
    { "type" => "Type2", 
     "weight" => "70", 
     "height" => "170", 
     "sole_length" => "315", 
     "birthday_year" => "1983",
     "birthday_month" => "01",
     "birthday_day" => "01" }  
  end
  subject(:expected_preped) do
    { :type => "Type2", 
     :weight => 70.0, 
     :height => 170.0, 
     :sole_length => 315.0, 
     :birthday_year => 1983,
     :birthday_month => 1,
     :birthday_day => 1 }  
  end
  subject(:expected_aged) do
    { :type => "Type2", 
     :weight => 70.0, 
     :height => 170.0, 
     :sole_length => 315.0, 
     :age => 30 }  
  end
  subject(:expected_validated) do
    { :type => 1, 
     :weight => 70.0, 
     :height => 170.0, 
     :sole_length => 315.0, 
     :age => 30 }  
  end
  subject(:expected_code) { 11 }
  subject(:expected_setting) do
    { :z_value => 6 }
  end
  
  before(:all) do
    #freeze time! so birthday will always be 30 years back
    Timecop.freeze(2013, 8, 13)                  
  end

  describe "#new" do
    it { SkiBinding::Calculator.new.class.should == SkiBinding::Calculator }
  end
  
  describe "#validate_attrs" do
    subject(:calculated_attr_validation) { SkiBinding::Calculator.validate_attrs(parameters) }
    let(:parameters) do
      skiers_parameters[:weight] = ""
      skiers_parameters[:height] = ""
      skiers_parameters
    end
    
    it "raise error with two messages" do
      expect { calculated_attr_validation }.to raise_error(SkiBinding::Error) do |e|
        e.message.should == {:weight => "weight is blank", :height => "height is blank"}
      end 
    end
    #it { expect { calculated_attr_validation }
    #     .to raise_error(ArgumentError, "height is blank") }
  end
  
  describe "#prep_attributes" do
    subject(:calculated_preped) { SkiBinding::Calculator.prep_attributes(parameters) }
    let(:parameters) { skiers_parameters }
    
    it { calculated_preped.should == expected_preped }
    
    context "when hash keys are strings" do
      let(:parameters) { skiers_parameters_string_keys}
      it { calculated_preped.should == expected_preped }
    end
    
    context "when weight < 10kg" do
      let(:parameters) do
        skiers_parameters[:weight] = 9 
        skiers_parameters
      end
      it { expect { calculated_preped }
           .to raise_error(ArgumentError, "Weight must be at least 10kg") }
    end
  end
  
  describe "#age" do
    subject(:calculated_aged) { SkiBinding::Calculator.age(preped) }
    let(:preped) { expected_preped }
    
    it { calculated_aged.should == expected_aged }
  end
  
  describe "#validate_type" do
    subject(:calculated_validated) { SkiBinding::Calculator.validate_type(aged) }
    let(:aged) { expected_aged }
    
    it "sets \"Type2\" to 1" do
      calculated_validated.should == expected_validated
    end
    
    context "when type is \"unknown\"" do
      let(:aged) do
        expected_aged[:type] = "unknown"
        expected_aged
      end
      
      it{ expect { calculated_validated }
          .to raise_error(ArgumentError, "You have entered an invalid type.") }
    end
  end
     
  describe "#binding_code" do
    subject(:calculated_code) { SkiBinding::Calculator.binding_code(validated) }
    let(:validated) { expected_validated }
    
    it{ calculated_code.should == 11 }
    
    context "when weight < 13kg" do
      let(:validated) do
        expected_validated[:weight] = 12
        expected_validated
      end
      #because "Type 2" is given the code would be changed to 1
      it{ calculated_code.should == 0 }
    end
    
    context "when no code found" do
      let(:validated) do 
        expected_validated[:weight] = -1
        expected_validated[:height] = -1
        expected_validated
      end
      
      it { expect { calculated_code }.
           to raise_error(ArgumentError, "You have entered invalid weight and/or height") }
    end
    
    context "when age >= 50 || age < 10" do             
      context "age is 50" do
        let(:validated) do
          expected_validated[:age] = 50
          expected_validated
        end
        
        it { calculated_code.should == (expected_code - 1) }                                  
      end
      
      context "age is 51" do
        let(:validated) do
          expected_validated[:age] = 51
          expected_validated
        end
        
        it { calculated_code.should == (expected_code - 1) }
      end
      
      context "age is 9" do
        let(:validated) do
          expected_validated[:age] = 9
          expected_validated
        end
        
        it { calculated_code.should == (expected_code - 1) }
      end
    end
  end
 
  describe "#binding_setting" do
    subject(:calculated_setting) { SkiBinding::Calculator.binding_setting(validated, binding_code) }
    let(:binding_code) { expected_code }
    let(:validated) { expected_validated }
    
    it{ calculated_setting.should == expected_setting }
    
    context "when no setting found" do
      let(:binding_code) { 0 }
      it{ expect { calculated_setting }
          .to raise_error(ArgumentError, "Please calculate z-index by hand.") }
    end
  end
 
  describe "#setting" do
    subject(:all_at_once_calculated) { SkiBinding::Calculator.setting(parameters) }
    let(:parameters) { skiers_parameters }
    
    it{ all_at_once_calculated.should == expected_setting }
  end
  
  after(:all) do
    Timecop.return
  end
end
