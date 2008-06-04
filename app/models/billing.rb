class Billing < ActiveRecord::Base
  
  def self.bulk_update_or_create(array_of_attributes)
    for attrs in array_of_attributes || []
      id = attrs.delete('id')
      id.blank? ? create(attrs) : Billing.find(id).update_attributes(attrs)
    end
  end
  
end
