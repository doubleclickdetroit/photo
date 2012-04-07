require 'spec_helper'

describe InvitationsController do
  attr_accessor :valid_attributes, :valid_session

  before(:each) do
    # UserMailer.stub_chain(:send_invitation) { mock_model(UserMailer) }
    # Invitation.class_eval do
    #   private
    #   alias :after_create_processing_orig :after_create_processing 
    #   def after_create_processing
    #     # wish i could cleanly stub private methods
    #   end
    # end
  end

  context 'admin logged in' do
    login_admin()

    describe "POST create" do
      it "should throw an error if no entity_id" do
        post :create, { :invitaiton => {} }, valid_session
        response.status.should == 406
      end

      it "should create a Invitation" do
        invitation = Factory.build(:invitation, :with_inviter_and_group)
        # # todo maybe try to get this to work instead...
        # expect{
        #   post :create, {:group_id => @the_group.to_param, :invitation => invitation}, valid_session
        # }.to change(Invitation, :count).by(1)

        Invitation.stub(:create)
        Invitation.should_receive(:create)
        post :create, {:group_id => @the_group.to_param, :invitation => invitation}, valid_session
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
        invitation = Factory(:invitation, :with_inviter_and_group)
        Invitation.should_receive(:find).with(invitation.to_param)
        get :show, { :id => invitation.to_param }, valid_session
      end
    end
    pending 'GET show'

    describe "DELETE destroy" do
      it "destroy the Invitation" do
        invitation = Factory(:invitation, :with_inviter_and_group)
        expect{
          delete :destroy, {:id => invitation.to_param}, valid_session
        }.to change(Invitation, :count).by(-1)
      end
    end

  end

  after(:all) do
    # Invitation.class_eval do
    #   private
    #   alias :after_create_processing :after_create_processing_orig
    #   def after_create_processing
    #     # wish i could cleanly stub private methods
    #   end
    # end
  end
end
