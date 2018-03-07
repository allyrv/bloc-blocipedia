class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

    has_many :wikis, dependent: :destroy
    has_many :collaborators
    has_many :shared_wikis, through: :collaborators, source: :wiki

    before_save { self.email = email.downcase }
    before_save {self.role ||= :standard }

    enum role: [:standard, :premium, :admin]
    after_initialize :set_default_role, :if => :new_record?

    def set_default_role
        self.role ||= :standard
    end
end 
