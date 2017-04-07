class AddBelongsToInAnswer < ActiveRecord::Migration[5.0]
  def change
    change_table :answers do |t|
      t.belongs_to :question
      t.belongs_to :survey
    end
  end
end
