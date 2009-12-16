class BillItem < ActiveRecord::Base
  belongs_to :bill
  belongs_to :product_batch
end
