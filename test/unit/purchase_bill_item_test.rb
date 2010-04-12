require 'test_helper'

class PurchaseBillItemTest < ActiveSupport::TestCase
  test "purchase bill item sets rate and vat for product batch on create" do
    Factory(:franchise, :name => 'DPPL - Vijayawada')
    purchase_bill_item = Factory.create(:purchase_bill_item)

    assert_equal purchase_bill_item.vat, purchase_bill_item.product_batch.vat
    assert_equal purchase_bill_item.rate, purchase_bill_item.product_batch.rate
  end
end
