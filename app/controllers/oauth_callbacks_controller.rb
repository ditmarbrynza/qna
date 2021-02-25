# frozen_string_literal: true

class OauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :find_user, only: %i[github vkontakte]

  def github
    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      redirect_to root_path, alert: 'Somethin went wrong'
    end
  end

  def vkontakte
    if @auth&.uid && !@user&.auth_confirmed?(@auth)
      redirect_to new_authorization_path(uid: @auth.uid, provider: @auth.provider)
    elsif @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Vk') if is_navigational_format?
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end

  private

  def find_user
    @auth = request.env['omniauth.auth']
    @user = User.find_for_oauth(@auth)
  end
end
