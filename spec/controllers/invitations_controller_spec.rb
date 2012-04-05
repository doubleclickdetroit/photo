require 'spec_helper'

describe InvitationsController do
  attr_accessor :valid_attributes, :valid_session

  context 'admin logged in' do
    login_admin()

    # describe 'authorization' do
    #   before(:each) do
    #     invitation = Factory.build(:invitation)
    #     @params = {
    #       comment:   comment,
    #       entity_id: @event.to_param 
    #     }
    #     @session = valid_session
    #   end
    #   pending 'create action spec is failing...'
    #   # it_should_check_permissions(@params, @session, :create, :update, :destroy)
    #   it_should_check_permissions(@params, @session, :update, :destroy)
    # end


    describe "POST create" do
      it "should throw an error if no entity_id" do
        post :create, { :invitaiton => {} }, valid_session
        response.status.should == 406
      end

      it "should create a Invitation" do
        invitation = Factory.build(:invitation)
        Invitation.class_eval do
          def after_create_processing
            # wish i could cleanly stub private methods
          end
        end
        expect{
          post :create, {:group_id => @the_group.to_param, :invitation => invitation}, valid_session
        }.to change(Invitation, :count).by(1)
      end
    end

    describe "GET index" do
      it "should throw an error if no entity_id" do
        get :index, {}, valid_session
        response.status.should == 406
      end

      it "should call Group#invitations" do
        Group.any_instance.should_receive :invitations
        get :index, { :group_id => @the_group.to_param}, valid_session
      end
    end

    describe "GET show" do
      it "should call Invitation#find" do
        invitation = Factory(:invitation)
        Invitation.should_receive(:find).with(invitation.to_param)
        get :show, { :id => invitation.to_param }, valid_session
      end
    end
    pending 'GET show'

    describe "DELETE destroy" do
      it "destroy the Invitation" do
        invitation = Factory(:invitation)
        expect{
          delete :destroy, {:id => invitation.to_param}, valid_session
        }.to change(Invitation, :count).by(-1)
      end
    end

  end
end
