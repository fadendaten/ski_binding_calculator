require "spec_helper"

describe DriverType do

  describe ".new" do
    it "should create a new DriverType" do
      DriverType.new("1", -1).class.should == DriverType
    end
  end

  describe "methods" do
    before(:each) do
      @driver = DriverType.new("1", -1)
    end

    describe "name" do
      it "should have a driver type name" do
        @driver.name.should == "1"
      end

      it "should be a string" do
        @driver.name.class.should == String
      end
    end

   describe "moving_value" do
     it "should have a moving value" do
       @driver.moving_value.should == -1
     end

     it "should be a fixnum" do
       @driver.moving_value.class.should == Fixnum 
     end
   end
  end
end
