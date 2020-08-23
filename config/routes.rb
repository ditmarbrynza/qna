Rails.application.routes.draw do
  root to: 'questions#index'
  devise_for :users
  
  resources :questions, except: :index, shallow: true do
    resources :answers, except: :index, shallow: true
  end
end
