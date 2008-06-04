require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/billing_bulks/new" do
  before(:each) do
    @billings = (1..3).map do |i|
      mock_model(Billing, :id => i,
                          :resourcename => "name#{i}"
                           )
    end
    assigns[:billings] = @billings
    render 'billing_bulks/new'
  end
  
  it "should wrap the billings in form for bulk update" do
    response.should have_tag("form") do
      with_tag "[action=?]", "/billing_bulk"
      with_tag "[method=?]", "post"
    end
  end
  
  it "should show the billings resourcenames in textfields" do
    for billing in @billings
      response.should have_tag("input") do
        with_tag "[type=?]", "text"
        with_tag "[value=?]", billing.resourcename
      end
    end
  end

  it "should provide a new billing link" do
    response.should have_tag("a", "new billing")
  end

  it "should have a submit button" do
    response.should have_tag("input") do
      with_tag "[type=?]", "submit"
      with_tag "[value=?]", "bulk-update"
    end
  end
end
