# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @link = Link.find(params[:id])
    @link.delete if current_user.author_of?(@link.linkable)
  end
end
