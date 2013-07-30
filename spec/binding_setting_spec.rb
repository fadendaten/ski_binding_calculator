require 'spec_helper'

describe BindingSetting do

  before(:each) do
    @hash = {(1..250) => {:z_value => 1.5, :my => 52, :mz => 14}}
    @index = Index.new(1, @hash)
  end

  describe "new" do
    it "should return a Index class" do
      Index.new(0, @hash).class.should == Index
    end
  end

  describe "size" do
    it "should return the size range" do
      @index.size.should == (1..250)
    end
    
    it "should be a range" do
      @index.size.class.should == Range
    end
  end

  describe "z_value" do
    it "should respond to z_value" do
      @index.should respond_to :z_value
    end

    it "should return the z_value" do
      @index.z_value.should == 1.5
    end
  end

end
