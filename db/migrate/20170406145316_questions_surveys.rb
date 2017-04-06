class QuestionsSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_surveys, id: false do |t|
      t.belongs_to :question
      t.belongs_to :survey
    end
  end
end
