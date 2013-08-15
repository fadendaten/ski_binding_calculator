require 'spec_helper'

describe SkiBinding::Code do
  describe "#new" do
    it "should return a Code class" do
      SkiBinding::Code.new.class.should == SkiBinding::Code
    end
  end
    
  context "when instantiated Code class" do
    it { should respond_to :weight }
    it { should respond_to :height }
  end
end

