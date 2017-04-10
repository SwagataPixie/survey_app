class AddAnswerTimeToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :answer_time, :string
  end
end
