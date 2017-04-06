class Survey < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :questions
  has_many :answer_times, through: :questions

  def update_time_remaining
  end

  def update_score
  end

  def number_of_questions_attempted
  end

  def passed?
  end
end
