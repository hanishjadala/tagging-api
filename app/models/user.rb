class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist  

  validates :first_name, :last_name,  presence: true
  before_create :downcase_fields

  acts_as_taggable_on :tags

  def downcase_fields
  	self.first_name = self.first_name.strip.titleize
  	self.last_name = self.last_name.strip.titleize
  	self.email = self.email.strip.downcase
  end 

  def self.search_filter(search)
    if search
      where("email ILIKE ? OR first_name ILIKE ?  OR last_name ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    end
  end            
end
