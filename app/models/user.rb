class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.maintain_sessions = false
  end

  ROLES = %w[admin franchise operator]

  def role_symbols
    role.underscore.to_sym
  end
end
