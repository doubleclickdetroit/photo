Photo::Application.routes.draw do
  devise_for :users

  resources :groups do
    # resources :users, :name_prefix => 'user_'
    # resources :projects, :name_prefix => 'projects_'

    # resources :users, :as => 'user'
    # resources :projects, :as => 'projects'

    resources :users
    resources :projects
  end

  resources :projects
 
  resources :memberships

  root :to => 'home#index'

  match '/profile/:username', :controller => :profile, :action => :show
end
