require 'spec_helper'

describe CommentsController do
  attr_accessor :valid_attributes, :valid_session

  context 'user not logged in' do
    login_admin()

    # before(:each) do
    #   # @project = Factory(:project)
    #   # @entity  = Factory(:entity)
    #   # @project.entities << @entity
    #   # @group.projects << @project
    # end

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

    describe "GET show" do
      it "should perform a Comment.find" do
        Comment.should_receive :find
        get :show, {:id => 1}, valid_session
      end
    end

    describe "POST create" do
      it "should create a Comment" do
        expect{
          post :create, {:comment => Factory.build(:comment).to_hash}, valid_session
        }.to change(Comment, :count).by(1)
      end
    end

    describe "PUT update" do
      it "should call Comment#update_attributes" do
        comment = Factory(:comment)
        Comment.any_instance.should_receive :update
        put :update, {:id => comment.to_param, :comment => {:text => 'PUT update'}}, valid_session
      end
    end

    describe "DELETE destroy" do
      it "destroy the Comment" do
        comment = Factory(:comment)
        expect{
          delete :destroy, {:id => comment.to_param}, valid_session
        }.to change(Comment, :count).by(-1)
      end
    end

  end
end
