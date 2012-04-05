CRM::Application.routes.draw do
  root :to => 'home#index'

  scope 'api' do
    devise_for :users

    resources :groups, :except => [:new, :edit] do
      # todo these probably dont go where they should
      resources :users, :except => [:new, :edit]

      resources :projects, :except => [:new, :edit]
      resources :invitations, :only => [:index, :show, :create, :destroy]
    end

    resources :projects, :except => [:new, :edit] do
      # routes for Task, Event, etc
      Entity::TYPES.each do |subclass|
        str = subclass.to_s
        sym = str.downcase.pluralize.intern
        resources sym, :controller => 'entities', :type => str, :except => [:new, :edit] 
      end
    end

    resources :entities, :except => [:new, :edit] do
      resources :comments, :only => [:create, :update, :destroy]
      resources :watchings, :only => [:create, :destroy]
    end
  end

  # match '/profile/:username', :controller => :profile, :action => :show
end
