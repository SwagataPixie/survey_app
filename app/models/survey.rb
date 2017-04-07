class Survey < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :surveys
  has_and_belongs_to_many :questions
  has_many :answer_times, through: :questions

  after_commit :number_of_questions_attempted, :passed?, :state

  def number_of_questions_attempted
    self.answers.pluck(:question_id).uniq.size
  end

  def passed?
    score >= pass_marks
  end

  def score
    score = 0
    self.questions.each do |question|
      choice_ids_for_answer = question.answers.where(survey_id: self.id).pluck(:id)
      correct_choice_ids = question.choices.where(correct: true).pluck(:id)
      score += 1 if choice_ids_for_answer == correct_choice_ids
    end
  end

  def state
    if remaining_time.to_i == 0
      passed? ? 'Passed' : 'Failed'
    else
      'Incomplete'
    end
  end
end