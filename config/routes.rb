Photo::Application.routes.draw do
  scope 'api' do
    devise_for :users

    resources :invitations, :only => [:create, :destroy]

    resources :groups, :except => [:new, :edit] do
      resources :users, :except => [:new, :edit]
      resources :projects, :except => [:new, :edit]
    end

    # does this belong with Groups?
    resources :memberships, :only => [:create, :destroy]

    resources :projects, :except => [:new, :edit] do
      # routes for Task, Event, etc
      Entity::TYPES.each do |subclass|
        str = subclass.to_s
        sym = str.downcase.pluralize.intern
        resources sym, :controller => 'entities', :type => str, :except => [:new, :edit] 
      end
    end
  end

  root :to => 'home#index'

  # match '/profile/:username', :controller => :profile, :action => :show
end
