require 'spec_helper'

describe SkiBinding::Person do
  before :all do
    @hash = {:type => "Type2", :weight => 70, :height => 170, :shoe_size => 315, :age => 30}
  end
    
  describe "new" do
    it "should return a Person class" do
      SkiBinding::Person.new(@hash).class.should == SkiBinding::Person
    end
  end
    
  context "instantiated Person class" do
    before :all do
      @person = SkiBinding::Person.new(@hash)
    end
    
    it "has attribute type" do
      @person.should respond_to :type
    end
    
    it "has attribute weight" do
      @person.should respond_to :weight
    end
    
    it "has attribute heigth" do
      @person.should respond_to :height
    end
    
    it "has attribute shoe_size" do
      @person.should respond_to :shoe_size
    end
    
    it "has attribute age" do
      @person.should respond_to :age
    end
    
    describe "validates type" do
      it "sets \"Type2\" to 1" do
        @person.type.should == 1
      end
      
      it "sets type \"unknown\" to nil" 
    end
  end
end
