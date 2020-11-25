# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false, index: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
