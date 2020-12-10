# frozen_string_literal: true

module AnswerHelper
  LIKE = 1
  LIKED = 1
  DISLIKE = -1
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

  def liked?(vote)
    vote == LIKED
  end

  def disliked?(vote)
    vote == DISLIKED
  end
end
