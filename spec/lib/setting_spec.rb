require 'spec_helper'

describe SkiBinding::Setting do
  describe "#new" do
    it "should return a Setting class" do
      SkiBinding::Setting.new.class.should == SkiBinding::Setting
    end
  end
    
  context "when instantiated Setting class" do
    it { should respond_to :shoe_size_range }
    it { should respond_to :z_value }
    it { should respond_to :twist }
    it { should respond_to :forward_lean }
  end
end
