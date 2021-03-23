# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError do |exception|
    respond_to do |format|
      format.html do
        flash[:alert] = exception.message
        redirect_to root_path
      end
      format.json { render json: ["You don't have permission to access on this server"], status: :forbidden }
      format.js { render json: ["You don't have permission to access on this server"], status: :forbidden }
    end
  end
end
