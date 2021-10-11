class UserProfile < ApplicationRecord
  belongs_to :user

  validates :name, :social_name, :birth_date, :major, :bio, :experience, :picture, presence: true
end
