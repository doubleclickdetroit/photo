require 'spec_helper'

describe CommentsController do
  attr_accessor :valid_attributes, :valid_session

  context 'user not logged in' do
    login_admin_and_populate_projects_and_entities()

    describe "GET index" do
      it "should throw an error if no entity_id" do
        get :index, {}, valid_session
        response.status.should == 406
      end

      it "should make a call to Entity#comments" do
        entity = Factory(:entity)
        Entity.any_instance.should_receive :comments
        get :index, {:entity_id => entity.to_param}, valid_session
      end
    end

    # describe "GET show" do
    #   it "should perform a Comment.find" do
    #     comment = Factory.build(:comment)
    #     @event.comments << comment
    #     get :show, {:id => comment.to_param}, valid_session
    #   end
    # end

    describe "POST create" do
      it "should throw an error if no entity_id" do
        post :create, {:comment => Factory.build(:comment).to_hash}, valid_session
        response.status.should == 406
      end

      it "should create a Comment" do
        comment = Factory.build(:comment)
        @event.comments << comment
        expect{
          post :create, {:entity_id => @event.to_param, :comment => comment.to_hash}, valid_session
        }.to change(Comment, :count).by(1)
      end
    end

    describe "PUT update" do
      it "should call Comment#update_attributes" do
        comment = Factory(:comment, :user_id => @user.id)
        @event.comments << comment
        Comment.any_instance.should_receive :update
        put :update, {:id => comment.to_param, :comment => {:text => 'PUT update'}}, valid_session
      end
    end

    describe "DELETE destroy" do
      it "destroy the Comment" do
        comment = Factory(:comment, :user_id => @user.id)
        @event.comments << comment
        expect{
          delete :destroy, {:id => comment.to_param}, valid_session
        }.to change(Comment, :count).by(-1)
      end
    end

  end
end
