class User < ActiveRecord::Base
  attr_accessible :crypted_password, :email, :login, :perishable_token, :persistence_token, :role, :single_access_token
  
  ROLES = %w[admin moderator author banned]
  
  acts_as_authentic do |c|
    # for available options see documentation in: Authlogic::ActsAsAuthentic
  end # block optional
  
  
  
end
