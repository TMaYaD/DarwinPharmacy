namespace :stocks do
  desc "Import Stock Inventory from closingstocks.csv and output rejects to multiple and notfound lists"
  task :import => :environment do
    require 'csv'
    CSV.open('closingstocks.multiple.csv', 'w') do |multiple|
    CSV.open('closingstocks.notfound.csv', 'w') do |notfound|
      CSV.open('closingstocks.csv', 'r') do |row|
        batches = ProductBatch.batch_code_is(row[2]).all
        if batches.count == 1
          #puts row.inspect
          #batch = batches[0]
          #product = batch.product
          #franchise_id = Franchise.find_by_name("DPPL - Vijayawada").id
          #stock_inventory = StockInventory.find_or_initialize_by_product_batch_id_and_franchise_id(batch.id, franchise_id)
          #product.name = row[1]
          #product.units = row[3].to_f
          #batch.pack = row[3].to_f
          #batch.exp_date = Date.strptime(row[4], "%y-%b")
          #product.mrp = row[5].to_f
          #batch.mrp = row[5].to_f
          #stock_inventory.increment(:quantity, row[6].to_f)
          #product.strength = row[7]
          #product.dosage = row[8]
#
          #product.save
          #batch.save
          #stock_inventory.save
#
        elsif batches.count > 1
          #puts "many found #{batch}"
          multiple << row
        else
          notfound << row
        end
      end
    end # close notfound
    end # close multiple
  end

  desc "Regenerate running stock inventory from recent audits"
  task :regenerate_for_store => :environment do
    franchise_id = Franchise.find_by_name("DPPL - Vijayawada").id
    default_date = Date.parse("01 Apr 2010")
    # import the values from audited_stock_records 
    ProductBatch.all.each { |product_batch|
      audited_stock_record = AuditedStockRecord.product_batch_id_is(product_batch.id).franchise_id_is(franchise_id).all(:order => 'created_at desc', :limit =>1).first
      if audited_stock_record
	quantity = audited_stock_record.quantity
        date = audited_stock_record.created_at
      else
	quantity = 0
	date = default_date
      end

      purchase_bill_items = PurchaseBillItem.product_batch_id_is(product_batch.id).created_at_greater_than(date)
      quantity += purchase_bill_items.sum(:sale_quantity) + purchase_bill_items.sum(:free_quantity)

      quantity -= SaleBillItem.product_batch_id_is(product_batch.id).created_at_greater_than(date).sum(:quantity)

      running_stock_record = RunningStockRecord.find_or_initialize_by_product_batch_id_and_franchise_id(product_batch.id, franchise_id)
      running_stock_record.quantity = quantity
      running_stock_record.save
    }
  end
end
