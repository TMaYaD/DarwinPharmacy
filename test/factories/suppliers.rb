Factory.define :supplier do |s|
  s.sequence(:name) {|n| "supplier_#{n}" }
end
