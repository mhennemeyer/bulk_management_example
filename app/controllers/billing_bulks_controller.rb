class BillingBulksController < ApplicationController
  
  def new
    @billings = params[:billing_ids] ? Billing.find(params[:billing_ids]) : [Billing.new]
  end

  def create
    Billing.bulk_update_or_create(params[:billings])
    redirect_to billings_path
  end

end
