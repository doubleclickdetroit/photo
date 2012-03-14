Photo::Application.routes.draw do
  devise_for :users

  resources :groups do
    resources :users
    resources :projects
  end

  # does this belong with Groups?
  resources :memberships


  resources :projects do
    resources :entities

    # routes for Task, Event, etc
    Entity::TYPES.each do |subclass|
      str = subclass.to_s
      sym = str.downcase.pluralize.intern
      resources sym, :controller => 'entities', :type => str 
    end
  end

  resources :entities
  root :to => 'home#index'

  match '/profile/:username', :controller => :profile, :action => :show
end
