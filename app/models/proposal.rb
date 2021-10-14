class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :presentation, :charges, :week_hours, :total_hours, presence: true
end
