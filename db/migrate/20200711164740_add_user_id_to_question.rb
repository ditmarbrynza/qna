# frozen_string_literal: true

class AddUserIdToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :questions, :user, index: true, foreign_key: true
  end
end
