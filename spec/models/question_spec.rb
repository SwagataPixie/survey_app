require 'rails_helper'

RSpec.describe Question, type: :model do
  (1..4).to_a.each do |number|
    let("correct_choice_#{number}".to_sym) { FactoryGirl.create(:choice) }
  end

  (1..4).to_a.each do |number|
    let("wrong_choice_#{number}".to_sym) { FactoryGirl.create(:choice, correct: false) }
  end

  let(:question_type) {
    FactoryGirl.create(
      :question_type,
      name: 'Comment',
      code: 'comment'
    )
  }

  context '#Single Choice' do
    let(:question_type) {
      FactoryGirl.create(
        :question_type,
        name: 'Single Choice',
        code: 'single_choice'
      )
    }

    it 'does not accept more than one correct choice' do
      question = Question.new(statement: 'Any?', question_type: question_type)
      question.choices << [correct_choice_1, correct_choice_2, correct_choice_3, correct_choice_4]
      expect(question.valid?).to be_falsey
    end

    it 'accepts one correct choice' do
      question = Question.new(statement: 'Any?', question_type: question_type)
      question.choices << [correct_choice_1, wrong_choice_2, wrong_choice_3, wrong_choice_4]
      expect(question.valid?).to be_truthy
    end
  end

  context '#Comment' do
    let(:question_type) {
      FactoryGirl.create(
        :question_type,
        name: 'Comment',
        code: 'comment'
      )
    }

    it 'does not accept one choice' do
      question = Question.new(statement: 'Any?', question_type: question_type)
      question.choices << [correct_choice_1, correct_choice_2, correct_choice_3, correct_choice_4]
      expect(question.valid?).to be_falsey
    end

    it 'accepts one choice only' do
      question = Question.new(statement: 'Any?', question_type: question_type)
      question.choices << [correct_choice_1]
      expect(question.valid?).to be_truthy
    end

    it 'accepts one corerct choice only' do
      question = Question.new(statement: 'Any?', question_type: question_type)
      question.choices << [wrong_choice_1]
      expect(question.valid?).to be_falsey
    end
  end

  it 'throws error if there is no choice' do
    question = Question.new(statement: 'Any?', question_type: question_type)
    expect(question.valid?).to be_falsey
  end
end
