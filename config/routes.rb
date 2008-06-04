ActionController::Routing::Routes.draw do |map|
  map.resources :billings
  map.resource  :billing_bulk
end
