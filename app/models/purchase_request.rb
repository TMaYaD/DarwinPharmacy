class PurchaseRequest < ActiveRecord::Base
  belongs_to :product
  include Product::AutocompleteFields

  belongs_to :franchise

  def before_validation
    self.franchise = Authorization.current_user.franchises[0]
  end
end
