# frozen_string_literal: true

class SubscribersController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize Subscriber
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      head :ok
    else
      render json: @subscriber.errors.messages
    end
  end

  def destroy
    find_subscriber
    authorize @subscriber
    if @subscriber.delete
      head :ok
    else
      render json: @subscriber.errors.messages
    end
  end

  private

  def subscriber_params
    params.permit(:user_id, :question_id)
  end

  def find_subscriber
    @subscriber = Subscriber.find(params[:id])
  end
end
