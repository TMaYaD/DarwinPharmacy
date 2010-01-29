Factory.define :franchise do |f|
  f.sequence(:name) {|n| "supplier_#{n}" }
end
