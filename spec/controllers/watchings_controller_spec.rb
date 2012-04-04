require 'spec_helper'

describe WatchingsController do
  attr_accessor :valid_attributes, :valid_session

  context 'admin logged in' do
    login_admin_and_populate_projects_and_entities()

    describe 'authorization' do
      before(:each) do
        watching = Factory.build(:watching)
        @params = {
          watching:   watching,
          entity_id: @event.to_param 
        }
        @session = valid_session
      end
      pending 'create action spec is failing...'
      # it_should_check_permissions(@params, @session, :create, :destroy)
      it_should_check_permissions(@params, @session, :destroy)
    end

    describe "POST create" do
      it "should throw an error if no entity_id" do
        post :create, {:watching => Factory.build(:watching).to_hash}, valid_session
        response.status.should == 406
      end

      it "should create a Watching" do
        watching = Factory.build(:watching)
        expect{
          post :create, {:entity_id => @event.to_param, :watching => watching.to_hash}, valid_session
        }.to change(Watching, :count).by(1)
      end
    end

    describe "DELETE destroy" do
      it "destroy the Watching" do
        watching = Factory(:watching, :user_id => @user.id)
        @event.watchings << watching
        expect{
          delete :destroy, {:id => watching.to_param}, valid_session
        }.to change(Watching, :count).by(-1)
      end
    end

  end
end
