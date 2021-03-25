# frozen_string_literal: true

class CreateSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribers do |t|
      t.belongs_to :question, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
