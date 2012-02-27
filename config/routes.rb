Photo::Application.routes.draw do
  devise_for :users

  resources :groups do
    resources :users
    resources :projects
  end

  resources :projects do
    resources :entities
    # resources :tasks, :controller => 'entities', :requirements => {:type => 'task'}
    resources :tasks, :controller => 'entities', :type => 'task'
  end

  resources :entities
  resources :memberships

  root :to => 'home#index'

  match '/profile/:username', :controller => :profile, :action => :show
end
