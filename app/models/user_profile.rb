class UserProfile < ApplicationRecord
  belongs_to :user

  validates :name, :social_name, :birth_date, :picture, presence: true
  validates :major, :bio, :experience, presence: true, if: :is_hireable?

  private

  def is_hireable?
    user.role == 'hireable'
  end

end
