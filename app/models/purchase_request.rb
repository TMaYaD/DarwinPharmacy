class PurchaseRequest < ActiveRecord::Base
  belongs_to :product
  include Product::AutocompleteFields

  belongs_to :store

  def before_validation
    self.store = Authorization.current_user.stores[0]
  end
end
