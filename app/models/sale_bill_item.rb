class SaleBillItem < ActiveRecord::Base
  belongs_to :sale_bill
  belongs_to :product_batch
end
