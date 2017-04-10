class QuestionsController < ApplicationController
  def update
    question = Question.find(params.require(:question_id))
    survey = Survey.find(params.require(:id))
    #Update Answer
    params[:question][:choice_ids].each do |choice_id|
      Answer.create(
        survey_id: survey.id,
        question_id: question.id,
        choice_id: choice_id,
        answer_time: params[:question][:time_taken]
      )
    end
    #Update remaining time
    remaining_survey_time = survey.remaining_time.to_i - params[:question][:time_taken].to_i
    survey.update_attributes(remaining_time: remaining_survey_time.to_s)
    #Redirect based on next qyestion id
    next_question_id = survey.remaining_question_ids_array.first
    if next_question_id
      redirect_to question_show_path(id: survey.id, question_id: next_question_id)
    else
      redirect_to survey_path
    end
  end

  def show
    @survey = Survey.find(params.require(:id))
    @question = Question.find(params.require(:question_id))
  end
end
