# frozen_string_literal: true

module Voted
  extend ActiveSupport::Concern

  def up
    votable = find_votable
    vote = Vote.up(current_user, votable)
    respond_to do |format|
      if vote.nil? || vote.save
        format.json do
          render json: { votable_id: votable.id,
                         rating: votable.rating,
                         model: votable.class.name.underscore,
                         user_vote: user_vote(vote) }
        end
      else
        format.json do
          render json: vote.errors.messages, status: :unprocessable_entity
        end
      end
    end
  end

  def down
    votable = find_votable
    vote = Vote.down(current_user, votable)
    respond_to do |format|
      if vote.nil? || vote.save
        format.json do
          render json: { votable_id: votable.id,
                         rating: votable.rating,
                         model: votable.class.name.underscore,
                         user_vote: user_vote(vote) }
        end
      else
        format.json do
          render json: vote.errors.messages, status: :unprocessable_entity
        end
      end
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
