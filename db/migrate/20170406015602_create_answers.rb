class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :comment
      t.belongs_to :choice

      t.timestamps
    end
  end
end
