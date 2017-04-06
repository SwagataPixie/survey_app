class Question < ApplicationRecord
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :surveys
  belongs_to :question_type
  has_many :answer_times, through: :surveys
  has_many :choices
end
