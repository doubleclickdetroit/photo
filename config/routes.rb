Photo::Application.routes.draw do
  scope 'api' do
    devise_for :users

    resources :invitations

    #check
    resources :groups do
      #todo
      resources :users
      #check
      resources :projects
    end

    #todo
    # does this belong with Groups?
    resources :memberships


    #check
    resources :projects do
      #todo
      resources :entities

      #todo
      # routes for Task, Event, etc
      Entity::TYPES.each do |subclass|
        str = subclass.to_s
        sym = str.downcase.pluralize.intern
        resources sym, :controller => 'entities', :type => str 
      end
    end
  end

  root :to => 'home#index'

  match '/profile/:username', :controller => :profile, :action => :show
end
