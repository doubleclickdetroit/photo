Photo::Application.routes.draw do
  devise_for :users

  resources :groups
  root :to => 'home#index'

  match '/profile/:username', :controller => :profile, :action => :show
end
