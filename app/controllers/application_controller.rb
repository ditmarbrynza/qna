# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    if request_format == :html
      flash[:alert] = exception.message
      redirect_to root_path
    else
      respond_to do |format|
        format.json { render json: ["You don't have permission to access on this server"], status: :forbidden }
        format.js { render json: ["You don't have permission to access on this server"], status: :forbidden }
      end
    end
  end
end
