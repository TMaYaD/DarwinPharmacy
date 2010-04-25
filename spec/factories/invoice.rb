Factory.define :invoice do |f|
  f.association :store
  f.association :customer, :factory => :store
end