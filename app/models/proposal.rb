class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :presentation, :charges, :week_hours, :total_hours, presence: true

  enum status: {pending:0, accepted:1, rejected:2}

end
