require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/billings/index" do
  before(:each) do
    @billings = (1..3).map {|i| mock_model(Billing, :id => i, :resourcename => "billing_#{i}") }
    assigns[:billings] = @billings
    render 'billings/index'
  end
  
  it "should show the billings resourcenames" do
    for billing in @billings
      response.should have_text(/#{billing.resourcename}/)
    end
  end
  
  it "should wrap the billings in a form for bulk management" do
    response.should have_tag("form") do
      with_tag "[action=?]",  "/billing_bulk/new"
      with_tag "[method=?]",  "get"
    end
  end
  
  it "should provide a checkbox for each billing" do
    for billing in @billings
      response.should have_tag("input") do
        with_tag "[type=?]", "checkbox"
        with_tag "[value=?]", billing.id
        with_tag "[name=?]", "billing_ids[]"
      end
    end
  end
  
  it "should have a submit button" do
    response.should have_tag("input") do
      with_tag "[type=?]", "submit"
      with_tag "[value=?]", "bulk-manage"
    end
  end
end
