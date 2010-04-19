class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.maintain_sessions = false
  end

  ROLES = %w[admin store operator accountant]

  has_and_belongs_to_many :stores

  validates_inclusion_of :role, :in => ROLES

  def role_symbols
    role ? [ role.underscore.to_sym ] : []
  end
end
