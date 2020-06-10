Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :questions, except: :index, shallow: true do
    resources :answers, except: :index, shallow: true
  end
end
