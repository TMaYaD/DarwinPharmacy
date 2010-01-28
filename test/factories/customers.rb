Factory.define :customer do |c|
  c.sequence(:phone) {|n| 1000000000+n }
  c.name 'fooer'
  c.address "1455, lorem ipsum lane\nSomewhere unknown"
end
