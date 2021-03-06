class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :type
      t.integer :number_of_question
      t.integer :pass_marks
      t.integer :score
      t.datetime :taken_on
      t.datetime :valid_from
      t.datetime :valid_till
      t.string :remaining_time
      t.belongs_to :user

      t.timestamps
    end
  end
end
