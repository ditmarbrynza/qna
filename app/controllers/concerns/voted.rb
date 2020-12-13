# frozen_string_literal: true

module Voted
  extend ActiveSupport::Concern

  included do
    before_action :find_votable, :find_vote, only: %i[like dislike]
  end

  def like
    if @vote.present?
      if @vote.like?
        @vote.click = nil
        @vote.destroy
        render_votable
      elsif @vote.dislike?
        @vote.destroy
        @vote = @votable.votes.create(user: current_user, click: :like)
        render_votable
      end
    else
      @vote = @votable.votes.create(user: current_user, click: :like)
      render_votable
    end
  end

  def dislike
    if @vote.present?
      if @vote.dislike?
        @vote.click = nil
        @vote.destroy
        render_votable
      elsif @vote.like?
        @vote.destroy
        @vote = @votable.votes.create(user: current_user, click: :dislike)
        render_votable
      end
    else
      @vote = @votable.votes.create(user: current_user, click: :dislike)
      render_votable
    end
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def find_votable
    @votable = model_klass.find(params['id'])
  end

  def find_vote
    @vote = @votable.votes.find_by(user: current_user)
  end

  def render_votable
    render json: {
      votable_id: @votable.id,
      rating: @votable.rating,
      model: @vote.votable_type.underscore,
      user_vote: @vote.click
    }
  end
end
