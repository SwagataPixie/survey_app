class User < ApplicationRecord
  validates :email, uniqueness: true
  has_many :surveys
end
