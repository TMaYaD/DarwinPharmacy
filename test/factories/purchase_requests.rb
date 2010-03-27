Factory.define :purchase_request do |r|
  r.association :product
  r.quantity 7
  r.association :franchise
end
