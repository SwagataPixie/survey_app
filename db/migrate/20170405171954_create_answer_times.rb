class CreateAnswerTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_times do |t|
      t.string :time

      t.timestamps
    end
  end
end
