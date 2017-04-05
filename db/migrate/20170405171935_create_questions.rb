class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :statement
      t.text :answer

      t.timestamps
    end
  end
end
