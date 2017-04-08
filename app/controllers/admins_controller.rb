class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def dashboard
  end

  def new_survey
    @tags = Tag.pluck(:name, :id)
  end

  def create_survey
    return false unless params[:survey]
    user = handle_user(params[:survey][:user_email], params[:survey][:user_name])
    questions =
      choose_questions_based_on_tag_and_number(params[:survey][:tag_id], params[:survey][:number_of_questions])
    survey_params = params.require(:survey)
      .permit(:valid_from, :valid_till, :pass_marks, :remaining_time)
    Survey.transaction do
      survey = Survey.create(survey_params)
      survey.questions << questions
      survey.user = user
      survey.save
    end
    redirect_to dashboard_path
  end

  def show_surveys
    @surveys = Survey.all unless params[:taken_from]
    @surveys = Survey.where('taken_on < ?, taken_on > ?', params[:taken_from], params[:taken_to])
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

  private

  def choose_questions_based_on_tag_and_number(tag_id, number_of_questions)
    tag = Tag.find(tag_id)
    questions = tag.questions.order('RAND()').limit(number_of_questions)
    return nil if questions.size < number_of_questions.to_i
    return questions
  end

  def handle_user(email, name=nil)
    user = User.where(email: email).first_or_create
    user.update_attributes(name: name)
    return user
  end
end
