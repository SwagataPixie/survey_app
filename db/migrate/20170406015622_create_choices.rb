class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.string :content
      t.boolean :correct
      t.belongs_to :question

      t.timestamps
    end
  end
end
