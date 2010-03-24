Factory.define :requirement do |r|
  r.association :product
  r.quantity 7
  r.association :franchise
end
