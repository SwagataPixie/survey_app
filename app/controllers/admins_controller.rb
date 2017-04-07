class AdminsController < ApplicationController
  def dashboard
  end

  def new_survey
  end

  def create_survey
    @tags = Tag.pluck(:name, :id)
  end

  def view_survey
  end

  def view_surveys
  end

  def new_question
    @question_types = QuestionType.pluck(:name, :id)
    @tags = Tag.pluck(:name, :id)
  end

  def create_question
    question = Question.create(statement: params[:question][:statement])
    (1..4).to_a.each do |number|
      choice_attributes = params[:question]["choice_#{number}".to_sym]
      question.choices.create(choice_attributes.to_hash)
    end
    question.tags << Tag.find(params[:question][:tag_id])
    redirect_to dashboard_path
  end
end
