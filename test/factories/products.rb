Factory.define :product do |p|
  p.sequence(:name) {|n| "foo_#{n}"}
  p.manufacturer 'bar pharma'
  p.composition 'bars and bars'
  p.dosage_form 'Tablets'
  p.strength '10mg'
end
