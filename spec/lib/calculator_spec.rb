require 'spec_helper'

describe SkiBinding::Calculator do
  before(:all) do
    @hash = {:type => "Type2", 
             :weight => "70", 
             :height => "170", 
             :shoe_size => "315", 
             :birthday => "1983-01-01"}                           
  end

  describe "#new" do
    it "returns a BindingCalculator class" do
      SkiBinding::Calculator.new.class.should == SkiBinding::Calculator
    end
  end
  
  describe "#prep_attributes" do
    it "returns a valid hash" do
      expected_hash = {:type => "Type2", 
                       :weight => 70.0, 
                       :height => 170.0, 
                       :shoe_size => 315.0, 
                       :birthday => "1983-01-01"}
      SkiBinding::Calculator.prep_attributes(@hash).should == expected_hash
    end
  end
  
  describe "#age" do
    before :all do
      @preped_hash = SkiBinding::Calculator.prep_attributes(@hash)
    end
    
    it "returns a hash with an age" do
      result = SkiBinding::Calculator.age(@preped_hash)
      result[:age].should == 30
    end
  end
  
  describe "#validate_type" do
    before :all do
      preped_hash = SkiBinding::Calculator.prep_attributes(@hash)
      @aged_hash = SkiBinding::Calculator.age(preped_hash)
    end
    
    it "sets \"Type2\" to 1" do
      result = SkiBinding::Calculator.validate_type(@aged_hash)
      result[:type].should == 1
    end
    
    it "sets type \"unknown\" to nil" do
      wrong_aged_hash = {:type => "unknown", 
               :weight => 70, 
               :height => 170, 
               :shoe_size => 315, 
               :age => 30}
      result = SkiBinding::Calculator.validate_type(wrong_aged_hash)
      result[:type].should == "unknown"
    end
  end
     
  
  describe "#binding_code" do
    before :each do
      preped_hash = SkiBinding::Calculator.prep_attributes(@hash)
      aged_hash = SkiBinding::Calculator.age(preped_hash)
      @type_validated_hash = SkiBinding::Calculator.validate_type(aged_hash)
    end
    
    it "returns a valid code" do
      SkiBinding::Calculator.binding_code(@type_validated_hash).should == 11
    end
    
    it "returns unchanged code if weight less than 13kg" do
      # because we set "Type2" the code would be changed by 1
      @type_validated_hash[:weight] = 12 
      SkiBinding::Calculator.binding_code(@type_validated_hash).should == 0
    end
    
    context "returns code one less if age >= 50 || age < 10" do
      before :each do
        preped_hash = SkiBinding::Calculator.prep_attributes(@hash)
        aged_hash = SkiBinding::Calculator.age(preped_hash)
        @type_validated_hash_age_context = SkiBinding::Calculator.validate_type(aged_hash)
        @code = SkiBinding::Calculator.binding_code(@type_validated_hash_age_context)
      end
      
      it "age is 50" do
        @type_validated_hash_age_context[:age] = 50
        lambda { @code = SkiBinding::Calculator.binding_code(@type_validated_hash_age_context) }
                                              .should change{@code}.by(-1)                                  
      end
      
      it "age is 51" do
        @type_validated_hash_age_context[:age] = 51
        lambda { @code = SkiBinding::Calculator.binding_code(@type_validated_hash_age_context) }
                                              .should change{@code}.by(-1)
      end
    end
  end
  
  describe "#binding_setting" do
    before :each do
      preped_hash = SkiBinding::Calculator.prep_attributes(@hash)
      aged_hash = SkiBinding::Calculator.age(preped_hash)
      @type_validated_hash = SkiBinding::Calculator.validate_type(aged_hash)
    end
    
    it "returns a valid setting" do
      SkiBinding::Calculator.binding_setting(@type_validated_hash, 11).should == 
      {"z_value"=>6}
    end
  end
  
  describe "#setting" do
    it "returns a valid setting" do
      SkiBinding::Calculator.setting(@hash).should == 
      {"z_value"=>6}
    end
  end
end
