require 'spec_helper'

describe BindingSetting do
  describe "new" do
    it "should return a BindingSetting class" do
      BindingSetting.new.class.should == BindingSetting
    end
  end
end
