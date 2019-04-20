Rails.application.routes.draw do
  root 'articles#index'
  resources :articles, except: :index do
  end
end
