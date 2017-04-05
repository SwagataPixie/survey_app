class Question < ApplicationRecord
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :surveys
  has_many :answer_times, through: :surveys
end
