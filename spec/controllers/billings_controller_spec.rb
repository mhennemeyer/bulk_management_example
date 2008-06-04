require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BillingsController do

  describe "GET 'index'" do
    
    def do_get
      get 'index'
    end
    
    before(:each) do
      @billings = (1..3).map {|i| mock_model(Billing)}
      Billing.stub!(:find).and_return(@billings)
    end
    
    it "should find all billings" do
      Billing.should_receive(:find).with(:all)
      do_get
    end
    
    it "should assign the billings to the view" do
      do_get
      assigns[:billings].should == @billings
    end
    
    it "should render 'index'" do
      do_get
      response.should render_template('billings/index')
    end
  end
end
