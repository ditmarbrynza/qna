# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError do |exeption|
    redirect_to root_url, alert: exeption.message
  end
end
