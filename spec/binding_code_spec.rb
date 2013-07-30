require 'spec_helper'

describe BindingCode do
  describe ".new" do
    it "should return a Criteria class" do
      BindingCode.new.class.should == BindingCode
    end
  end
end
