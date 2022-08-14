Rails.application.routes.draw do
  devise_for :users

  get '/admin' => 'users#admin'
  get '/userlist' => 'users#user_list'
  get '/commentlist' => 'users#comment_list'
  get '/articlelist' => 'users#article_list'
  get '/ajax_ogp' => 'functions#ajax_ogp', defaults: { format: :json }

  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :articles do
    resources :comments, only: [:create]
    resources :taggings, only: [:create]
  end
  resources :tags, only: [:create]
  resources :taggings, only: [:create]
  root 'articles#index'
end
