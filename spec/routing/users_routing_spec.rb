require "spec_helper"

describe DeviseController do

  describe "routing" do
    # todo dont need these...
    # new_user_session GET    /users/sign_in(.:format)                              devise/sessions#new
    # new_user_password GET    /users/password/new(.:format)                         devise/passwords#new
    # edit_user_password GET    /users/password/edit(.:format)                        devise/passwords#edit
    # new_user_registration GET    /users/sign_up(.:format)                              devise/registrations#new
    # edit_user_registration GET    /users/edit(.:format)                                 devise/registrations#edit

    describe 'devise/sessions' do
      it 'routes to #create' do
        post('/api/users/sign_in').should route_to('devise/sessions#create')
      end

      it 'routes to #destroy' do
        delete('/api/users/sign_out').should route_to('devise/sessions#destroy')
      end
    end

    describe 'devise/passwords' do
      it 'routes to #crate' do
        post('/api/users/password').should route_to('devise/passwords#create')
      end

      it 'routes to #destroy' do
        put('/api/users/password').should route_to('devise/passwords#update')
      end
    end

    describe 'devise/registrations' do
      it 'routes to #destroy' do
        get('/api/users/cancel').should route_to('devise/registrations#cancel')
      end

      it 'routes to #create' do
        post('/api/users').should route_to('devise/registrations#create')
      end

      it 'routes to #update' do
        put('/api/users').should route_to('devise/registrations#update')
      end

      it 'routes to #update' do
        delete('/api/users').should route_to('devise/registrations#destroy')
      end
    end
  end
end
