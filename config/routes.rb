# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'questions#index'
  devise_for :users

  resources :questions, except: :index, shallow: true do
    resources :answers, except: :index, shallow: true do
      member do
        patch :best
      end
    end
  end

  resources :files, only: :destroy

  resources :links, only: :destroy

  resources :awards, only: :index
end
