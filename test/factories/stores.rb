Factory.define :store do |f|
  f.sequence(:name) {|n| "supplier_#{n}" }
end
