class User < ActiveRecord::Base
  authenticates_with_sorcery!
    
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
   ROLES = %w[admin moderator author]

      def roles=(roles)
        self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
      end

      def roles
        ROLES.reject do |r|
          ((roles_mask || 0) & 2**ROLES.index(r)).zero?
        end
      end

    def role?(base_role)
        role.present? && ROLES.index(base_role.to_s) <= ROLES.index(role)
    end

    def is?(role)
        roles.include?(role.to_s)
    end
end

