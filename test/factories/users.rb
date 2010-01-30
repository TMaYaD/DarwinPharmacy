Factory.define :user do |u|
  u.sequence(:login) {|n| "foo_user_#{n}"}
  u.role 'admin'
  u.email {|a| "#{a.login}@darwin.co.in".downcase }
  u.password 'foobar'
  u.password_confirmation {|a| a.password}
end
