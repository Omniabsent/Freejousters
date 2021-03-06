class User < ApplicationRecord
  has_one :user_profile
  has_many :project
  has_many :proposal
  has_many :favourite

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
