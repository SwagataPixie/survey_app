class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :statement
      t.belongs_to :question_type

      t.timestamps
    end
  end
end
