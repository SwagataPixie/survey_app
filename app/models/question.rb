class Question < ApplicationRecord
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :surveys
  belongs_to :question_type
  has_many :answer_times, through: :surveys
  has_many :choices
  has_many :answers

  validate :question_to_answer_type

  def is_answered_correctly?(survey_id)
    answer_ids = answers.where(survey_id: survey_id).pluck(:choice_id).uniq
    answer_ids == correct_answer_array
  end

  def correct_answer_array
    choices.where(correct: true).pluck(:id).uniq
  end

  def answers_string
    choices.where(correct: true).pluck(:content).join(', ')
  end

  private

  def question_to_answer_type
    case question_type
    when QuestionType.find_by_code('single_choice')
      correct_choice_ids = choices.where(correct: true).pluck(:id).uniq
      errors.add(:question_type, 'Single choice only')
    when QuestionType.find_by_code('comment')
      errors.add(:question_type, 'Question type is comment') unless choices.count == 1
    end
  end
end
