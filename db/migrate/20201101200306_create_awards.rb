class CreateAwards < ActiveRecord::Migration[6.0]
  def change
    create_table :awards do |t|
      t.string :title, null: false
      t.belongs_to :question, foreign_key: true
      t.belongs_to :answer, foreign_key: true

      t.timestamps 
    end
  end
end
