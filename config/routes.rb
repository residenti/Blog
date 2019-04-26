Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  resources :articles, except: :index do
  end
end
