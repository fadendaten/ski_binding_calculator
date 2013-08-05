require 'spec_helper'

describe SkiBinding::Code do
  describe "#new" do
    it "should return a Code class" do
      SkiBinding::Code.new.class.should == SkiBinding::Code
    end
  end
    
  context "instantiated Code class" do
    before :all do
      @code = SkiBinding::Code.new
    end
    
    it "has attribute weight" do
      @code.should respond_to :weight
    end
    
    it "has attribute heigth" do
      @code.should respond_to :height
    end
  end
end

