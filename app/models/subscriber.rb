# frozen_string_literal: true

class Subscriber < ApplicationRecord
  belongs_to :question
  belongs_to :user
end
