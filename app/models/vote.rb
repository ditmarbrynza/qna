# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validate :author_cant_vote

  enum vote: { '1': 'like', '-1': 'dislike' }

  LIKE      = 1
  LIKED     = 1
  DISLIKE   = -1
  DISLIKED  = -1

  def self.up(user, votable)
    vote = Vote.find_by(user: user, votable: votable)
    if vote.present?
      case vote.value
      when LIKED
        vote.value -= 1
      when DISLIKED
        vote.value = vote.value * -1
      end
    else
      vote = Vote.new(user: user, votable: votable)
      vote.value = LIKE
    end
    return_vote(vote)
  end

  def self.down(user, votable)
    vote = Vote.find_by(user: user, votable: votable)
    if vote.present?
      case vote.value
      when LIKED
        vote.value = vote.value * -1
      when DISLIKED
        vote.value += 1
      end
    else
      vote = Vote.new(user: user, votable: votable)
      vote.value = DISLIKE
    end
    return_vote(vote)
  end

  def self.return_vote(vote)
    return vote unless vote.value.zero?

    vote.destroy
    nil
  end

  private

  def author_cant_vote
    errors.add(:user, "Author can't vote") if user&.author_of?(votable)
  end
end
