class Survey < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :surveys
  has_and_belongs_to_many :questions
  has_many :answers, through: :questions
  # paginates_per 5

  after_commit :number_of_questions_attempted, :passed?, :state

  def number_of_questions_attempted
    answers.pluck(:question_id).uniq.size
  end

  def passed?
    score >= pass_marks
  end

  def score
    score = 0
    questions.each do |question|
      score += 1 if question.is_answered_correctly?(id)
    end
    score
  end

  def state
    if remaining_time.to_i == 0
      passed? ? 'Passed' : 'Failed'
    else
      'Incomplete'
    end
  end

  def is_valid?
    Time.zone.now >= valid_from && Time.zone.now <= valid_till
  end

  def remaining_question_ids_array
    answered_question_ids_array = answers.where(survey_id: id).pluck(:question_id).uniq
    total_question_ids_array = questions.pluck(:id)
    total_question_ids_array - answered_question_ids_array
  end
end
