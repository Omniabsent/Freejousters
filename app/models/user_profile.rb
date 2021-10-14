class UserProfile < ApplicationRecord
  belongs_to :user
  has_many :proposal
  
  validates :name, :social_name, :birth_date, :major, :bio, :experience, :picture, presence: true
end
