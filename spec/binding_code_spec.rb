require 'spec_helper'

describe BindingCode do
  describe ".new" do
    it "should return a BindingCode class" do
      BindingCode.new.class.should == BindingCode
    end
  end
end
