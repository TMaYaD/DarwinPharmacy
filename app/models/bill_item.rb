class BillItem < ActiveRecord::Base
  belongs_to :bill
  belongs_to :product_batch

  def price
    self.product_batch.price * self.quantity * (100 - self.discount) /100
  end
end
