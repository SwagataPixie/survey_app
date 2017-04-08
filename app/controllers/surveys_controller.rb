class SurveysController < ApplicationController
  def show
    @survey = Survey.find(params.require(:id))
    return nil if @survey.remaining_question_ids_array.blank?
    @next_question_id = @survey.remaining_question_ids_array.first
  end

  def update
  end
end
