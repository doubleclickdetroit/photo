require 'spec_helper'

describe GroupsController do
  attr_accessor :valid_attributes, :valid_session

  # todo
  # if logged in
  # some actions should not require auth: index, create
  # some actions should: show, update, destroy


  context 'user not logged in' do
    let(:sign_in_alert) {'You need to sign in or sign up before continuing.'}

    describe "GET index" do
      it "redirects to sign_in with flash alert" do
        get :index, {}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "GET show" do
      it "redirects to sign_in with flash alert" do
        group = Factory(:group)
        get :show, {:id => group.to_param}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "POST create" do
      it "redirects to sign_in with flash alert" do
        post :create, {:group => {}}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "PUT update" do
      it "redirects to sign_in with flash alert" do
        group = Factory(:group)
        put :update, {:id => group.to_param, :group => {}}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "DELETE destroy" do
      it "redirects to sign_in with flash alert" do
        group = Factory(:group)
        delete :destroy, {:id => group.to_param}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

  end


  context 'owner for group logged in' do
    login_owner()

    describe "GET index" do
      it "assigns all groups as @groups" do
        get :index, {}, valid_session
        groups = [@the_group]
        assigns(:groups).should == groups
      end
    end

    describe "GET show" do
      it "assigns the requested group as @group" do
        get :show, {:id => @the_group.to_param}, valid_session
        assigns(:group).should == @the_group.to_hash 
      end
    end

    describe "POST create" do
      let(:valid_attributes) { Factory.build(:group).attributes }

      describe "with valid params" do
        it "creates a new Group" do
          expect {
            post :create, {:group => valid_attributes}, valid_session
          }.to change(Group, :count).by(1)
        end

        it "assigns a newly created group as @group" do
          post :create, {:group => valid_attributes}, valid_session
          assigns(:group).should be_a(Group)
          assigns(:group).should be_persisted
          assigns(:hash).should be_a(Hash)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved group as @group" do
          # Trigger the behavior that occurs when invalid params are submitted
          Group.any_instance.stub(:save).and_return(false)
          post :create, {:group => {}}, valid_session
          assigns(:group).should be_a_new(Group)
          assigns(:group).should_not be_persisted
        end
      end

    end

    describe "PUT update" do
      let(:valid_attributes) do
        { :name => 'Group PUT' }
      end

      describe "with valid params" do
        it "updates the requested group" do
          # Assuming there are no other groups in the database, this
          # specifies that the Group created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Group.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => @the_group.to_param, :group => {'these' => 'params'}}, valid_session
        end

        it "assigns the requested group as @group" do
          put :update, {:id => @the_group.to_param, :group => valid_attributes}, valid_session
          assigns(:group).should == @the_group 
        end
      end

      describe "with invalid params" do
        it "assigns the group as @group" do
          # Trigger the behavior that occurs when invalid params are submitted
          Group.any_instance.stub(:save).and_return(false)
          put :update, {:id => @the_group.to_param, :group => {}}, valid_session
          assigns(:group).should == @the_group 
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested group" do
        expect {
          delete :destroy, {:id => @the_group.to_param}, valid_session
        }.to change(Group, :count).by(-1)
      end
    end

  end


  context 'admin for group logged in' do
    login_admin()

    describe "GET index" do
      it "assigns all groups as @groups" do
        get :index, {}, valid_session
        groups = [@the_group]
        assigns(:groups).should == groups
      end
    end

    describe "GET show" do
      it "assigns the requested group as @group" do
        get :show, {:id => @the_group.to_param}, valid_session
        assigns(:group).should == @the_group.to_hash 
      end
    end

    describe "POST create" do
      let(:valid_attributes) { Factory.build(:group).attributes }

      describe "with valid params" do
        it "creates a new Group" do
          expect {
            post :create, {:group => valid_attributes}, valid_session
          }.to change(Group, :count).by(1)
        end

        it "assigns a newly created group as @group" do
          post :create, {:group => valid_attributes}, valid_session
          assigns(:group).should be_a(Group)
          assigns(:group).should be_persisted
          assigns(:hash).should be_a(Hash)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved group as @group" do
          # Trigger the behavior that occurs when invalid params are submitted
          Group.any_instance.stub(:save).and_return(false)
          post :create, {:group => {}}, valid_session
          assigns(:group).should be_a_new(Group)
          assigns(:group).should_not be_persisted
        end
      end

    end

    describe "PUT update" do
      let(:valid_attributes) do
        { :name => 'Group PUT' }
      end

      describe "with valid params" do
        it "updates the requested group" do
          # Assuming there are no other groups in the database, this
          # specifies that the Group created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Group.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => @the_group.to_param, :group => {'these' => 'params'}}, valid_session
        end

        it "assigns the requested group as @group" do
          put :update, {:id => @the_group.to_param, :group => valid_attributes}, valid_session
          assigns(:group).should == @the_group 
        end
      end

      describe "with invalid params" do
        it "assigns the group as @group" do
          # Trigger the behavior that occurs when invalid params are submitted
          Group.any_instance.stub(:save).and_return(false)
          put :update, {:id => @the_group.to_param, :group => {}}, valid_session
          assigns(:group).should == @the_group 
        end
      end
    end

    describe "DELETE destroy" do
      it "does not destroy the requested group" do
        expect {
          delete :destroy, {:id => @the_group.to_param}, valid_session
        }.to change(Group, :count).by(0)
      end
    end

  end
  

  context 'associate for group logged in' do
    login_associate()

    describe "GET index" do
      it "assigns all groups as @groups" do
        get :index, {}, valid_session
        groups = [@the_group]
        assigns(:groups).should == groups
      end
    end

    describe "POST create" do
      let(:valid_attributes) { Factory.build(:group).attributes }

      describe "with valid params" do
        it "creates a new Group" do
          expect {
            post :create, {:group => valid_attributes}, valid_session
          }.to change(Group, :count).by(1)
        end

        it "assigns a newly created group as @group" do
          post :create, {:group => valid_attributes}, valid_session
          assigns(:group).should be_a(Group)
          assigns(:group).should be_persisted
          assigns(:hash).should be_a(Hash)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved group as @group" do
          # Trigger the behavior that occurs when invalid params are submitted
          Group.any_instance.stub(:save).and_return(false)
          post :create, {:group => {}}, valid_session
          assigns(:group).should be_a_new(Group)
          assigns(:group).should_not be_persisted
        end
      end

    end

    describe "GET show" do
      it "assigns the requested group as @group" do
        get :show, {:id => @the_group.to_param}, valid_session
        assigns(:group).should == @the_group.to_hash 
      end
    end

    describe "PUT update" do
      let(:valid_attributes) do
        { :name => 'Name From Group PUT' }
      end

      it 'does not update the group' do
        group = @the_group
        put :update, {:id => @the_group.to_param, :group => valid_attributes}, valid_session
        @the_group.reload.should == group
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested group" do
        expect {
          delete :destroy, {:id => @the_group.to_param}, valid_session
        }.to change(Group, :count).by(0)
      end
    end

  end

end
