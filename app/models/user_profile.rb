class UserProfile < ApplicationRecord
  belongs_to :user

  if :check_if_hireable == true then
    validates :name, :social_name, :birth_date, :major, :bio, :experience, :picture, presence: true
  else
    validates :name, :social_name, :birth_date, :picture, presence: true
  end

  private

  def check_if_hireable
    @role == 'hireable'
  end
end
