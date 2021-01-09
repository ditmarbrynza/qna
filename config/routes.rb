# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'questions#index'
  devise_for :users

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

  mount ActionCable.server => '/cable'
end
