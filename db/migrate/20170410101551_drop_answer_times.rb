class DropAnswerTimes < ActiveRecord::Migration[5.0]
  def change
    drop_table :answer_times
  end
end
