Rails.application.routes.draw do
  devise_for :users

  get '/admin' => 'users#admin'
  get '/userlist' => 'users#user_list'
  get '/commentlist' => 'users#comment_list'
  get '/articlelist' => 'users#article_list'
  get '/urllist' => 'users#url_list'
  get '/taglist' => 'users#tag_list'
  get '/adminuserlist' => 'users#admin_user_list'
  get '/adminusernew' => 'users#admin_user_new'
  get '/tagginglist' => 'users#tagging_list'

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
