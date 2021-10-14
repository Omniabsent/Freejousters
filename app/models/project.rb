class Project < ApplicationRecord
  belongs_to :user
  has_many :proposal

  validates :title, :description, :wanted_skills, :max_pay, :expiration_date, presence: true
end
