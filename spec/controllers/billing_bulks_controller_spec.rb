require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BillingBulksController do

  describe "GET 'new'" do
    
    def do_get(options={})
      get 'new', options
    end
    
    describe "given params[:billing_ids]" do
      
      before(:each) do
        @billing_ids = [1,2,3]
        @billings    = @billing_ids.map {|i| mock_model(Billing, :id => i) }
        Billing.stub!(:find).and_return(@billings)
      end
      
      it "should find all billings given in params[:billing_ids]" do
        Billing.should_receive(:find).with(@billing_ids)
        do_get :billing_ids => @billing_ids
      end
      
      it "should should assign billings to view" do
        do_get :billing_ids => @billing_ids
        assigns[:billings].should == @billings
      end
      
      it "should render 'new'" do
        do_get :billing_ids => @billing_ids
        response.should render_template('billing_bulks/new')
      end
      
    end
    
    describe "given no params" do
      
      before(:each) do
        @billing  = mock_model(Billing)
        @billings = [@billing]
        Billing.stub!(:new).and_return(@billing)
      end
      
      it "should construct a new billing if params[:billing_ids] is empty" do
        Billing.should_receive(:new)
        do_get
      end

      it "should should assign billing to view" do
        do_get
        assigns[:billings].should == @billings
      end
      
      it "should render 'new'" do
        do_get
        response.should render_template('billing_bulks/new')
      end
    end
    
    
    
  end

  describe "POST 'create'" do
    def do_post(options={})
      post 'create', options
    end
      
    it "should call Billing.bulk_update_or_create(params[:billings])" do
      @billings = (1..3).map {|i| {"id" => i, "resourcename" => "name_#{i}"} }
      Billing.should_receive(:bulk_update_or_create).with(@billings)
      do_post :billings => @billings
    end
    it "should redirect to /billings" do
      do_post
      response.should redirect_to('/billings')
    end
  end
end
