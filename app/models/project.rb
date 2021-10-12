class Project < ApplicationRecord
  belongs_to :user

  validates :title, :description, :wanted_skills, :max_pay, :expiration_date, :remote, presence: true
end
