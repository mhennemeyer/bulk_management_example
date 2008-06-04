require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Billing do
  before(:each) do
    @billing = Billing.new
  end

  it "should be valid" do
    @billing.should be_valid
  end
  
  describe ".bulk_update_or_create(array_of_attributes=[])" do
    before(:each) do
      @attrs = {'id' => 1, :resourcename => "updated"}
      @billing = Billing.new
      @billing.stub!(:update_attributes)
    end
    it "should create Billing from attributes if no id given" do
      attrs = {'resourcename' => "new"}
      Billing.should_receive(:create).with(attrs)
      Billing.bulk_update_or_create([attrs])
    end
    
    it "should find billing that is referenced by id" do
      Billing.should_receive(:find).with(1).and_return(@billing)
      Billing.bulk_update_or_create([@attrs])
    end
    
    it "should update an existing billing that is referenced by id with attributes" do
      @billing.should_receive(:update_attributes).with(:resourcename => "updated")
      Billing.stub!(:find).and_return(@billing)
      Billing.bulk_update_or_create([@attrs])
    end
  end
  
end
