class RemoveTypeFromSurveys < ActiveRecord::Migration[5.0]
  def change
    change_table :surveys do |t|
      t.remove :type
      t.belongs_to :tag
    end
  end
end
