class Project < ApplicationRecord
  belongs_to :user
  has_many :proposal

  validates :title, :description, :wanted_skills, :max_pay, :expiration_date, presence: true

  enum status: {ativo:1, encerrado:2}

end
