class ChangeFieldNamesInProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.rename :category, :schedule
      t.rename :dosage, :dosage_form
    end
  end

  def self.down
    change_table :products do |t|
      t.rename :schedule, :category
      t.rename :dosage_form, :dosage
    end
  end
end
