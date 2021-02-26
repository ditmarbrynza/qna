# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OauthCallbacksController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'Github' do
    let(:oauth_data) { OmniAuth::AuthHash.new(provider: 'github', uid: 123) }
    it 'finds user from oauth data' do
      allow(request.env).to receive(:[]).and_call_original
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
      expect(User).to receive(:find_for_oauth).with(oauth_data)
      get :github
    end

    context 'user exist' do
      let!(:user) { create(:user) }

      before do
        allow(User).to receive(:find_for_oauth).and_return(user)
        get :github
      end

      it 'login user' do
        expect(subject.current_user).to eq user
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user does not exist' do
      before do
        allow(User).to receive(:find_for_oauth)
        get :github
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'does not login user' do
        expect(subject.current_user).to_not be
      end
    end
  end

  describe 'Vk' do
    let(:oauth_data) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: 123) }
    it 'finds user from oauth data' do
      allow(request.env).to receive(:[]).and_call_original
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
      expect(User).to receive(:find_for_oauth).with(oauth_data)
      get :vkontakte
    end

    context 'without authorization' do
      let(:oauth_data) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: 123, info: {}) }
      let!(:user) { create(:user) }

      before do
        allow(request.env).to receive(:[]).and_call_original
        allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
      end

      it 'redirect to email confirmation' do
        get :vkontakte
        expect(response).to redirect_to new_authorization_path(uid: oauth_data.uid, provider: oauth_data.provider)
      end

      it 'does not login user' do
        expect(subject.current_user).to be_nil
      end
    end

    context 'with unconfirmed email' do
      let!(:user) { create(:user) }

      before do
        allow(request.env).to receive(:[]).and_call_original
        allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
        user.create_unconfirmed_authorization(oauth_data)
        get :vkontakte
      end

      it 'redirect to email confirmation path' do
        expect(response).to redirect_to new_authorization_path(uid: oauth_data.uid, provider: oauth_data.provider)
      end

      it 'not login user' do
        expect(subject.current_user).to be_nil
      end
    end

    context 'with confirmed email' do
      let!(:user) { create(:user) }

      before do
        allow(User).to receive(:find_for_oauth).and_return(user)
        user.create_authorization(oauth_data)
        get :vkontakte
      end

      it 'login user' do
        expect(subject.current_user).to eq user
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user does not exist' do
      before do
        allow(User).to receive(:find_for_oauth)
        get :vkontakte
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'does not login user' do
        expect(subject.current_user).to_not be
      end
    end
  end
end
