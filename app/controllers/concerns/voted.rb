# frozen_string_literal: true

module Voted
  extend ActiveSupport::Concern

  def render_votable(votable, vote)
    render json: {
      votable_id: votable.id,
      rating: votable.rating,
      model: votable.class.name.underscore,
      user_vote: user_vote(vote)
    }
  end

  def up
    votable = find_votable
    vote = Vote.up(current_user, votable)
    if vote.nil? || vote.save
      render_votable(votable, vote)
    else
      render json: vote.errors.messages, status: :unprocessable_entity
    end
  end

  def down
    votable = find_votable
    vote = Vote.down(current_user, votable)
    if vote.nil? || vote.save
      render_votable(votable, vote)
    else
      render json: vote.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def find_votable
    model_klass.find(params['id'])
  end

  def user_vote(vote)
    Vote.votes[vote&.value.to_s]
  end
end
