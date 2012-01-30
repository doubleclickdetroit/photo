Photo::Application.routes.draw do
  devise_for :users

  root :to => 'home#index'

  match '/profile/:username', :controller => :profile, :action => :show
end
