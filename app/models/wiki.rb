class Wiki < ApplicationRecord
	belongs_to :user
  	after_initialize :init
  	scope :visible_to, -> (user) { user ? all : where(private: false) }

	private

    def init
        self.private = false if self.private.nil?
    end

    def publicize
    	update_attribute(:private, false)
  	end
end

