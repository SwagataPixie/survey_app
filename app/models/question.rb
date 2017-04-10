class Question < ApplicationRecord
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :surveys
  belongs_to :question_type
  has_many :choices
  has_many :answers, through: :surveys
  validates :choices, :length => { :minimum => 1 }

  validate :question_to_answer_type

  def is_answered_correctly?(survey_id)
    answer_ids = answers.where(survey_id: survey_id).pluck(:choice_id).uniq
    answer_ids == correct_answer_array
  end

  def answer_time(survey_id)
    answers.find_by_survey_id(survey_id).answer_time
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
      number_of_correct_choices = choices.to_a.select{|c| c if c.correct?}.count
      errors.add(:question_type, 'Single choice only') unless number_of_correct_choices == 1
    when QuestionType.find_by_code('multiple_choice')
      number_of_correct_choices = choices.to_a.select{|c| c if c.correct?}.count
      errors.add(:question_type, 'Multiple Choice') unless number_of_correct_choices > 1
    when QuestionType.find_by_code('comment')
      number_of_correct_choices = choices.to_a.select{|c| c if c.correct?}.count
      errors.add(:question_type, 'Question type is comment') unless choices.length == 1
      errors.add(:question_type, 'Comment cannot be wrong') unless number_of_correct_choices == 1
    end
  end

  def choices_association_present?
    choices.count > 0
  end
end
