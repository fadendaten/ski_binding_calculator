require 'spec_helper'


describe Criteria do

  before(:each) do
    @hash = {:weight => 10..13, :size => 10..148}
    @criteria = Criteria.new(@hash)
  end

  describe ".new" do
    it "should return a Criteria class" do
      Criteria.new(@hash).class.should == Criteria
    end
  end

  describe "weight" do
    it "shoud return the weight rang" do
      @criteria.weight.should == (10..13)
    end

    it "should be a range" do
      @criteria.weight.class.should == Range
    end
  end

  describe "size" do
    it "shoud return the size rang" do
      @criteria.size.should == (10..148)
    end

    it "should be a range" do
      @criteria.size.class.should == Range
    end
  end

end
