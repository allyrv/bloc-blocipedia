class Wiki < ApplicationRecord
	belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  	after_initialize :init
  	scope :visible_to, -> (user) { user ? all : where(private: false) }


    def init
        self.private = false if self.private.nil?
    end

    def publicize
    	update_attribute(:private, false)
  	end

    def collaborator?(user)
      collaborators.where(user_id: user.id).first
    end

end

