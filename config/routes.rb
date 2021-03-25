# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  root to: 'questions#index'
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
        get :all, on: :collection
      end
      resources :questions do
        get :index, on: :collection
        get :show, on: :collection
        get '/answers', to: 'questions#answers'
        post :create
        post :update
        delete :destroy
      end
      resources :answers do
        get :show, on: :collection
        post :create
        post :update
        delete :destroy
      end
    end
  end

  concern :votable do
    member do
      post :like
      post :dislike
    end
  end

  concern :commentable do
    resources :comments, only: [:create]
  end

  resources :questions, except: :index, shallow: true, concerns: %i[votable commentable] do
    resources :answers, except: :index, shallow: true, concerns: %i[votable commentable] do
      member do
        patch :best
      end
    end
  end

  resources :files, only: :destroy

  resources :links, only: :destroy

  resources :awards, only: :index

  resource :authorization, only: %i[new create] do
    get 'email_confirmation/:confirmation_token', action: :email_confirmation, as: :email_confirmation
  end

  mount ActionCable.server => '/cable'
end
