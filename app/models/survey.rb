class Survey < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :questions
  has_many :answer_times, through: :questions
end
