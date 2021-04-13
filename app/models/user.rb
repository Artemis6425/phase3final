class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :password
  validates_confirmation_of :password
  validates :name, :uniqueness => true
  has_many :runs
  has_many :games, through: :runs

end