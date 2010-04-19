Factory.define :user do |u|
  u.sequence(:login) {|n| "foo_user_#{n}"}
  u.role 'operator'
  u.email {|a| "#{a.login}@darwin.co.in".downcase }
  u.password 'foobar'
  u.password_confirmation {|a| a.password}
end

Factory.define :franchisee, :parent => :user do |u|
  u.role 'store'
  u.after_create {|u| u.stores = [Factory(:store)] }
end
