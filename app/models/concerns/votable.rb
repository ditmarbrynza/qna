# frozen_string_literal: true

module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def rating
    sum = 0
    votes.each do |vote|
      sum += convert_click(vote.click)
    end
    sum
  end

  private

  def convert_click(click)
    case click
    when 'like'
      1
    when 'dislike'
      -1
    end
  end
end
