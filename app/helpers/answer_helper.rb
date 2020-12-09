# frozen_string_literal: true

module AnswerHelper
  LIKED = 1
  DISLIKED = -1

  def how_voted(user, votable)
    vote = Vote.find_by(user: user, votable: votable)
    return unless vote.present?

    case vote.value
    when LIKE
      LIKED
    when DISLIKE
      DISLIKED
    end
  end

  def liked?(user, votable)
    vote = Vote.find_by(user: user, votable: votable)
    return unless vote.present?

    vote.value == LIKED
  end

  def disliked?(user, votable)
    vote = Vote.find_by(user: user, votable: votable)
    return unless vote.present?

    vote.value == DISLIKED
  end
end
