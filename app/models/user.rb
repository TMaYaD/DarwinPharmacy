class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.maintain_sessions = false
  end

  ROLES = %w[admin franchise operator]

  validates_inclusion_of :role, :in => ROLES

  def role_symbols
    role ? [ role.underscore.to_sym ] : []
  end
end
