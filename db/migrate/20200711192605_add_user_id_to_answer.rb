# frozen_string_literal: true

class AddUserIdToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :answers, :user, index: true, foreign_key: true
  end
end
