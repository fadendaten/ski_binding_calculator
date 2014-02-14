require 'spec_helper'
require 'timecop'

# The scenario: according to table B.1 in ISO 11088 a skier which is
# type 2, 70 kg of weight, 170cm of height, has a sole length of 
# 315mm, and is born 01/01/1983 has code "L" or in our notation 11 
# (see readme for details on codes). Furthermore it's z_value is 6.
describe SkiBinding::Calculator do
  let(:skiers_parameter) do
    { :type => "Type2", 
     :weight => "70", 
     :height => "170", 
     :sole_length => "315", 
     :birthday_year => "1983",
     :birthday_month => "01",
     :birthday_day => "01" }  
  end
  let(:skiers_parameter_string_keys) do
    { "type" => "Type2", 
     "weight" => "70", 
     "height" => "170", 
     "sole_length" => "315", 
     "birthday_year" => "1983",
     "birthday_month" => "01",
     "birthday_day" => "01" }  
  end
  let(:expected_preped) do
    { :type => "Type2", 
     :weight => 70.0, 
     :height => 170.0, 
     :sole_length => 315.0, 
     :birthday_year => 1983,
     :birthday_month => 1,
     :birthday_day => 1 }  
  end
  let(:expected_aged) do
    { :type => "Type2", 
     :weight => 70.0, 
     :height => 170.0, 
     :sole_length => 315.0, 
     :age => 30 }  
  end
  let(:expected_type_validated) do
    { :type => 1, 
     :weight => 70.0, 
     :height => 170.0, 
     :sole_length => 315.0, 
     :age => 30 }  
  end
  let(:expected_code) { 11 }
  let(:expected_setting) do
    { :z_value => 6 }
  end
  
  before(:all) do
    #freeze time! so birthday will always be 30 years back
    Timecop.freeze(2013, 8, 13)                  
  end
  
  describe ".validate_attrs" do
    let(:calculated_validated) { SkiBinding::Calculator.validate_attrs(parameters) }
    
    context "when attributes are blank" do
      let(:parameters) do
        skiers_parameter[:weight] = ""
        skiers_parameter[:height] = ""
        skiers_parameter
      end
      
      it "raises SkiBinding::Error" do
        expect { calculated_validated }.to raise_error(SkiBinding::Error)  { |e|
              e.messages.should == { :weight => "is blank", :height => "is blank" } }
      end
    end 
  end
  
  describe ".prep_attributes" do
    let(:calculated_preped) { SkiBinding::Calculator.prep_attributes(parameters) }
    
    context "when input hash keys are symbols" do
      let(:parameters) { skiers_parameter }
      
      it "calculates the expected preped hash" do
        expect(calculated_preped).to eq(expected_preped)
      end
    end
    
    context "when input hash key are strings" do
      let(:parameters) { skiers_parameter_string_keys}
      
      it "calculates the expected preped hash" do
         expect(calculated_preped).to eq(expected_preped)
      end
    end
    
    context "when weight is less than 10kg" do
      let(:parameters) do
        skiers_parameter[:weight] = 9 
        skiers_parameter
      end
      it "raises SkiBinding::Error" do
        expect { calculated_preped }.to raise_error(SkiBinding::Error) { |e|
          e.messages.should == { :weight => "is less than 10kg" } }
      end
    end
    
    context "when height is less than one" do
      let(:parameters) do
        skiers_parameter[:height] = 0
        skiers_parameter
      end
      it "raises SkiBinding::Error" do
        expect { calculated_preped }.to raise_error(SkiBinding::Error) { |e|
          e.messages.should == { :height => "must be bigger than 0" } }
      end
    end
    
    context "when sole_length is less than one" do
      let(:parameters) do
        skiers_parameter[:sole_length] = 0
        skiers_parameter
      end
      it "raises SkiBinding::Error" do
        expect { calculated_preped }.to raise_error(SkiBinding::Error) { |e|
          e.messages.should == { :sole_length => "must be bigger than 0" } }
      end
    end
  end
  
  describe ".age" do
    let(:calculated_aged) { SkiBinding::Calculator.age(expected_preped) }
    
    it "replaces birthday by age" do
      expect(calculated_aged).to eq(expected_aged)
    end
  end
  
  describe ".validate_type" do
    let(:calculated_type_validated) { SkiBinding::Calculator.validate_type(aged) }
    let(:aged) { expected_aged }
    
    it "sets 'Type2' to 1" do
      expect(calculated_type_validated[:type]).to eq(expected_type_validated[:type])
    end
    
    context "when type is 'unknown'" do
      let(:aged) do
        expected_aged[:type] = "unknown"
        expected_aged
      end
      
      it "raises SkiBinding::Error" do
        expect { calculated_type_validated }.to raise_error(SkiBinding::Error) { |e|
            e.messages.should == { :type => "You have entered an invalid type." } }
      end
    end
  end
     
  describe ".binding_code" do
    let(:calculated_code) { SkiBinding::Calculator.binding_code(validated) }
    let(:validated) { expected_type_validated }
    
    it "calculates the expected code" do
      expect(calculated_code).to eq(11)
    end
    
    context "when weight less than 13kg" do
      let(:validated) do
        expected_type_validated[:weight] = 12
        expected_type_validated
      end
      
      #because "Type 2" is given the code would be changed to 1
      it "code is unchanged" do
        expect(calculated_code).to eq(0)
      end
    end
    
    context "when no code found" do
      let(:validated) do 
        expected_type_validated[:weight] = -1
        expected_type_validated[:height] = -1
        expected_type_validated
      end
      
      it "raises SkiBinding::Error" do 
        expect { calculated_code }.to raise_error(SkiBinding::Error) { |e|
            e.messages.should == { :base => "You have entered invalid weight and/or height" } }
      end
    end
    
    context "when age is bigger or equal 50 or less than 10" do      
      context "when age is 50" do
        let(:validated) do
          expected_type_validated[:age] = 50
          expected_type_validated
        end
        
        it "code changes by -1" do
          expect(calculated_code).to eq(expected_code - 1) 
        end                                 
      end
      
      context "when age is 51" do
        let(:validated) do
          expected_type_validated[:age] = 51
          expected_type_validated
        end
        
        it "code changes by -1" do
          expect(calculated_code).to eq(expected_code - 1) 
        end             
      end
      
      context "when age is 9" do
        let(:validated) do
          expected_type_validated[:age] = 9
          expected_type_validated
        end
        
        it "code changes by -1" do
          expect(calculated_code).to eq(expected_code - 1) 
        end            
      end
    end
  end
  
  describe ".binding_setting" do
    let(:calculated_setting) { SkiBinding::Calculator.binding_setting(expected_type_validated, binding_code) }
    let(:binding_code) { expected_code }
    
    it "calculates the expected setting" do
      expect(calculated_setting).to eq(expected_setting)
    end
    
    context "when no setting found" do
      let(:binding_code) { 0 }
      
      it "raises SkiBinding::Error" do
        expect { calculated_setting }.to raise_error(SkiBinding::Error) { |e|
            e.messages.should == { :base => "Please calculate z-index by hand." } }
      end
    end
  end
  
  describe ".setting" do
    subject(:one_pass_calculated_setting) { SkiBinding::Calculator.setting(skiers_parameter) }
    
    it "calculates the expected setting in one pass" do
      expect(one_pass_calculated_setting).to eq(expected_setting)
    end
  end
  
  after(:all) do
    Timecop.return
  end
end
