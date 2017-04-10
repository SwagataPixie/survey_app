class QuestionType < ApplicationRecord
  has_many :questions

  validates_presence_of :code, :name
  validates_uniqueness_of :code
end
