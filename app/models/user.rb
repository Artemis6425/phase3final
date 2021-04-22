class User < ApplicationRecord
  has_secure_password
  validates_confirmation_of :password
  validates :name, :uniqueness => true, length: { in: 4..16 }
  has_many :runs
  has_many :games, through: :runs

end