class BillingsController < ApplicationController
  
  def index
    @billings = Billing.find(:all)
  end

end
