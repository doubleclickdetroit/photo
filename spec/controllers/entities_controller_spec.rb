require 'spec_helper'

describe EntitiesController do
  attr_accessor :valid_attributes, :valid_session

  context 'admin logged in' do
    login_admin_and_populate_projects_and_entities()

    describe 'authorization' do
      before(:each) do
        entity = Factory.build(:entity)
        @params = {
          entity:   entity,
          phase_id: @phase.to_param 
        }
        @session = valid_session
      end
      pending 'ensure all actions are covered'
      # it_should_check_permissions(@params, @session, :index, :show, :create, :update, :destroy)
      it_should_check_permissions(@params, @session, :update, :destroy)
    end

    # describe 'GET index' do
    #   it 'should call Phase.find(param[:phase_id]) and .entities on the return' do
    #     phase_id = '1'
    #     Phase.should_receive(:find).with(phase_id)
    #     get :index, { :phase_id => phase_id }
    #   end
    # end

    # describe 'GET show' do
    #   it 'should call Entity.find(param[:id])' do
    #     pending 'receiving message twice...'
    #     id = '1'
    #     Entity.should_receive(:find).with(id)
    #     get :show, { :id => id }
    #   end
    # end

    describe "POST create" do
      it "should throw an error if no phase_id" do
        post :create, { :entity => {} }, valid_session
        response.status.should == 406
      end

      it "should create an Entity" do
        pending
        entity = Factory.build(:entity)
        expect{
          post :create, {:phase_id => @phase.to_param, :entity => entity.attributes.merge({type: 'Task'})}, valid_session
        }.to change(Entity, :count).by(1)
      end
    end

    describe "PUT update" do
      it "should call Entity#update_attributes" do
        entity = Factory(:entity)
        @phase.entities << entity
        Entity.any_instance.should_receive :update
        # todo better param...
        put :update, {:id => entity.to_param, :entity => {:phase_id => '1'}}, valid_session
      end
    end

    describe "DELETE destroy" do
      it "destroy the Entity" do
        entity = Factory(:entity)
        @phase.entities << entity
        expect{
          delete :destroy, {:id => entity.to_param}, valid_session
        }.to change(Entity, :count).by(-1)
      end
    end

  end

end

# describe EntitiesController do
#   attr_accessor :valid_attributes, :valid_session
# 
# 
#   context 'user not logged in' do
#     let(:sign_in_alert) {'You need to sign in or sign up before continuing.'}
# 
#     describe "GET index" do
#       it "redirects to sign_in with flash alert" do
#         get :index, {}, valid_session
#         response.should redirect_to(new_user_session_path)
#         flash[:alert].should == sign_in_alert
#       end
#     end
# 
#     describe "GET show" do
#       it "redirects to sign_in with flash alert" do
#         entity = Factory(:entity)
#         get :show, {:id => entity.to_param}, valid_session
#         response.should redirect_to(new_user_session_path)
#         flash[:alert].should == sign_in_alert
#       end
#     end
# 
#     describe "POST create" do
#       it "redirects to sign_in with flash alert" do
#         post :create, {:entity => {}}, valid_session
#         response.should redirect_to(new_user_session_path)
#         flash[:alert].should == sign_in_alert
#       end
#     end
# 
#     describe "PUT update" do
#       it "redirects to sign_in with flash alert" do
#         entity = Factory(:entity)
#         put :update, {:id => entity.to_param, :entity => {}}, valid_session
#         response.should redirect_to(new_user_session_path)
#         flash[:alert].should == sign_in_alert
#       end
#     end
# 
#     describe "DELETE destroy" do
#       it "redirects to sign_in with flash alert" do
#         entity = Factory(:entity)
#         delete :destroy, {:id => entity.to_param}, valid_session
#         response.should redirect_to(new_user_session_path)
#         flash[:alert].should == sign_in_alert
#       end
#     end
# 
#   end
# 
# 
#   # context 'owner for group logged in' do
#   #   login_owner()
# 
#   #   describe "GET index" do
#   #     it "assigns all groups as @groups" do
#   #       get :index, {}, valid_session
#   #       groups = [@the_group]
#   #       assigns(:groups).should == groups
#   #     end
#   #   end
# 
#   #   describe "GET show" do
#   #     it "assigns the requested group as @group" do
#   #       get :show, {:id => @the_group.to_param}, valid_session
#   #       assigns(:group).should == @the_group.to_hash 
#   #     end
#   #   end
# 
#   #   describe "POST create" do
#   #     let(:valid_attributes) { Factory.build(:group).attributes }
# 
#   #     describe "with valid params" do
#   #       it "creates a new Group" do
#   #         expect {
#   #           post :create, {:group => valid_attributes}, valid_session
#   #         }.to change(Group, :count).by(1)
#   #       end
# 
#   #       it "assigns a newly created group as @group" do
#   #         post :create, {:group => valid_attributes}, valid_session
#   #         assigns(:group).should be_a(Group)
#   #         assigns(:group).should be_persisted
#   #         assigns(:hash).should be_a(Hash)
#   #       end
#   #     end
# 
#   #     describe "with invalid params" do
#   #       it "assigns a newly created but unsaved group as @group" do
#   #         # Trigger the behavior that occurs when invalid params are submitted
#   #         Group.any_instance.stub(:save).and_return(false)
#   #         post :create, {:group => {}}, valid_session
#   #         assigns(:group).should be_a_new(Group)
#   #         assigns(:group).should_not be_persisted
#   #       end
#   #     end
# 
#   #   end
# 
#   #   describe "PUT update" do
#   #     let(:valid_attributes) do
#   #       { :name => 'Group PUT' }
#   #     end
# 
#   #     describe "with valid params" do
#   #       it "updates the requested group" do
#   #         # Assuming there are no other groups in the database, this
#   #         # specifies that the Group created on the previous line
#   #         # receives the :update_attributes message with whatever params are
#   #         # submitted in the request.
#   #         Group.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
#   #         put :update, {:id => @the_group.to_param, :group => {'these' => 'params'}}, valid_session
#   #       end
# 
#   #       it "assigns the requested group as @group" do
#   #         put :update, {:id => @the_group.to_param, :group => valid_attributes}, valid_session
#   #         assigns(:group).should == @the_group 
#   #       end
#   #     end
# 
#   #     describe "with invalid params" do
#   #       it "assigns the group as @group" do
#   #         # Trigger the behavior that occurs when invalid params are submitted
#   #         Group.any_instance.stub(:save).and_return(false)
#   #         put :update, {:id => @the_group.to_param, :group => {}}, valid_session
#   #         assigns(:group).should == @the_group 
#   #       end
#   #     end
#   #   end
# 
#   #   describe "DELETE destroy" do
#   #     it "destroys the requested group" do
#   #       expect {
#   #         delete :destroy, {:id => @the_group.to_param}, valid_session
#   #       }.to change(Group, :count).by(-1)
#   #     end
#   #   end
# 
#   # end
# 
# 
#   # context 'admin for group logged in' do
#   #   login_admin()
# 
#   #   describe "GET index" do
#   #     it "assigns all groups as @groups" do
#   #       get :index, {}, valid_session
#   #       groups = [@the_group]
#   #       assigns(:groups).should == groups
#   #     end
#   #   end
# 
#   #   describe "GET show" do
#   #     it "assigns the requested group as @group" do
#   #       get :show, {:id => @the_group.to_param}, valid_session
#   #       assigns(:group).should == @the_group.to_hash 
#   #     end
#   #   end
# 
#   #   describe "POST create" do
#   #     let(:valid_attributes) { Factory.build(:group).attributes }
# 
#   #     describe "with valid params" do
#   #       it "creates a new Group" do
#   #         expect {
#   #           post :create, {:group => valid_attributes}, valid_session
#   #         }.to change(Group, :count).by(1)
#   #       end
# 
#   #       it "assigns a newly created group as @group" do
#   #         post :create, {:group => valid_attributes}, valid_session
#   #         assigns(:group).should be_a(Group)
#   #         assigns(:group).should be_persisted
#   #         assigns(:hash).should be_a(Hash)
#   #       end
#   #     end
# 
#   #     describe "with invalid params" do
#   #       it "assigns a newly created but unsaved group as @group" do
#   #         # Trigger the behavior that occurs when invalid params are submitted
#   #         Group.any_instance.stub(:save).and_return(false)
#   #         post :create, {:group => {}}, valid_session
#   #         assigns(:group).should be_a_new(Group)
#   #         assigns(:group).should_not be_persisted
#   #       end
#   #     end
# 
#   #   end
# 
#   #   describe "PUT update" do
#   #     let(:valid_attributes) do
#   #       { :name => 'Group PUT' }
#   #     end
# 
#   #     describe "with valid params" do
#   #       it "updates the requested group" do
#   #         # Assuming there are no other groups in the database, this
#   #         # specifies that the Group created on the previous line
#   #         # receives the :update_attributes message with whatever params are
#   #         # submitted in the request.
#   #         Group.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
#   #         put :update, {:id => @the_group.to_param, :group => {'these' => 'params'}}, valid_session
#   #       end
# 
#   #       it "assigns the requested group as @group" do
#   #         put :update, {:id => @the_group.to_param, :group => valid_attributes}, valid_session
#   #         assigns(:group).should == @the_group 
#   #       end
#   #     end
# 
#   #     describe "with invalid params" do
#   #       it "assigns the group as @group" do
#   #         # Trigger the behavior that occurs when invalid params are submitted
#   #         Group.any_instance.stub(:save).and_return(false)
#   #         put :update, {:id => @the_group.to_param, :group => {}}, valid_session
#   #         assigns(:group).should == @the_group 
#   #       end
#   #     end
#   #   end
# 
#   #   describe "DELETE destroy" do
#   #     it "does not destroy the requested group" do
#   #       expect {
#   #         delete :destroy, {:id => @the_group.to_param}, valid_session
#   #       }.to change(Group, :count).by(0)
#   #     end
#   #   end
# 
#   # end
#   # 
# 
#   # context 'associate for group logged in' do
#   #   login_associate()
# 
#   #   describe "GET index" do
#   #     it "assigns all groups as @groups" do
#   #       get :index, {}, valid_session
#   #       groups = [@the_group]
#   #       assigns(:groups).should == groups
#   #     end
#   #   end
# 
#   #   describe "POST create" do
#   #     let(:valid_attributes) { Factory.build(:group).attributes }
# 
#   #     describe "with valid params" do
#   #       it "creates a new Group" do
#   #         expect {
#   #           post :create, {:group => valid_attributes}, valid_session
#   #         }.to change(Group, :count).by(1)
#   #       end
# 
#   #       it "assigns a newly created group as @group" do
#   #         post :create, {:group => valid_attributes}, valid_session
#   #         assigns(:group).should be_a(Group)
#   #         assigns(:group).should be_persisted
#   #         assigns(:hash).should be_a(Hash)
#   #       end
#   #     end
# 
#   #     describe "with invalid params" do
#   #       it "assigns a newly created but unsaved group as @group" do
#   #         # Trigger the behavior that occurs when invalid params are submitted
#   #         Group.any_instance.stub(:save).and_return(false)
#   #         post :create, {:group => {}}, valid_session
#   #         assigns(:group).should be_a_new(Group)
#   #         assigns(:group).should_not be_persisted
#   #       end
#   #     end
# 
#   #   end
# 
#   #   describe "GET show" do
#   #     it "assigns the requested group as @group" do
#   #       get :show, {:id => @the_group.to_param}, valid_session
#   #       assigns(:group).should == @the_group.to_hash 
#   #     end
#   #   end
# 
#   #   describe "PUT update" do
#   #     let(:valid_attributes) do
#   #       { :name => 'Name From Group PUT' }
#   #     end
# 
#   #     it 'does not update the group' do
#   #       group = @the_group
#   #       put :update, {:id => @the_group.to_param, :group => valid_attributes}, valid_session
#   #       @the_group.reload.should == group
#   #     end
#   #   end
# 
#   #   describe "DELETE destroy" do
#   #     it "destroys the requested group" do
#   #       expect {
#   #         delete :destroy, {:id => @the_group.to_param}, valid_session
#   #       }.to change(Group, :count).by(0)
#   #     end
#   #   end
# 
#   # end
# 
# 
# 
# #   # This should return the minimal set of attributes required to create a valid
# #   # Entity. As you add validations to Entity, be sure to
# #   # update the return value of this method accordingly.
# #   def valid_attributes
# #     {}
# #   end
# #   
# #   # This should return the minimal set of values that should be in the session
# #   # in order to pass any filters (e.g. authentication) defined in
# #   # EntitiesController. Be sure to keep this updated too.
# #   def valid_session
# #     {}
# #   end
# # 
# #   describe "GET index" do
# #     it "assigns all entities as @entities" do
# #       entity = Entity.create! valid_attributes
# #       get :index, {}, valid_session
# #       assigns(:entities).should eq([entity])
# #     end
# #   end
# # 
# #   describe "GET show" do
# #     it "assigns the requested entity as @entity" do
# #       entity = Entity.create! valid_attributes
# #       get :show, {:id => entity.to_param}, valid_session
# #       assigns(:entity).should eq(entity)
# #     end
# #   end
# # 
# #   describe "GET new" do
# #     it "assigns a new entity as @entity" do
# #       get :new, {}, valid_session
# #       assigns(:entity).should be_a_new(Entity)
# #     end
# #   end
# # 
# #   describe "GET edit" do
# #     it "assigns the requested entity as @entity" do
# #       entity = Entity.create! valid_attributes
# #       get :edit, {:id => entity.to_param}, valid_session
# #       assigns(:entity).should eq(entity)
# #     end
# #   end
# # 
# #   describe "POST create" do
# #     describe "with valid params" do
# #       it "creates a new Entity" do
# #         expect {
# #           post :create, {:entity => valid_attributes}, valid_session
# #         }.to change(Entity, :count).by(1)
# #       end
# # 
# #       it "assigns a newly created entity as @entity" do
# #         post :create, {:entity => valid_attributes}, valid_session
# #         assigns(:entity).should be_a(Entity)
# #         assigns(:entity).should be_persisted
# #       end
# # 
# #       it "redirects to the created entity" do
# #         post :create, {:entity => valid_attributes}, valid_session
# #         response.should redirect_to(Entity.last)
# #       end
# #     end
# # 
# #     describe "with invalid params" do
# #       it "assigns a newly created but unsaved entity as @entity" do
# #         # Trigger the behavior that occurs when invalid params are submitted
# #         Entity.any_instance.stub(:save).and_return(false)
# #         post :create, {:entity => {}}, valid_session
# #         assigns(:entity).should be_a_new(Entity)
# #       end
# # 
# #       it "re-renders the 'new' template" do
# #         # Trigger the behavior that occurs when invalid params are submitted
# #         Entity.any_instance.stub(:save).and_return(false)
# #         post :create, {:entity => {}}, valid_session
# #         response.should render_template("new")
# #       end
# #     end
# #   end
# # 
# #   describe "PUT update" do
# #     describe "with valid params" do
# #       it "updates the requested entity" do
# #         entity = Entity.create! valid_attributes
# #         # Assuming there are no other entities in the database, this
# #         # specifies that the Entity created on the previous line
# #         # receives the :update_attributes message with whatever params are
# #         # submitted in the request.
# #         Entity.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
# #         put :update, {:id => entity.to_param, :entity => {'these' => 'params'}}, valid_session
# #       end
# # 
# #       it "assigns the requested entity as @entity" do
# #         entity = Entity.create! valid_attributes
# #         put :update, {:id => entity.to_param, :entity => valid_attributes}, valid_session
# #         assigns(:entity).should eq(entity)
# #       end
# # 
# #       it "redirects to the entity" do
# #         entity = Entity.create! valid_attributes
# #         put :update, {:id => entity.to_param, :entity => valid_attributes}, valid_session
# #         response.should redirect_to(entity)
# #       end
# #     end
# # 
# #     describe "with invalid params" do
# #       it "assigns the entity as @entity" do
# #         entity = Entity.create! valid_attributes
# #         # Trigger the behavior that occurs when invalid params are submitted
# #         Entity.any_instance.stub(:save).and_return(false)
# #         put :update, {:id => entity.to_param, :entity => {}}, valid_session
# #         assigns(:entity).should eq(entity)
# #       end
# # 
# #       it "re-renders the 'edit' template" do
# #         entity = Entity.create! valid_attributes
# #         # Trigger the behavior that occurs when invalid params are submitted
# #         Entity.any_instance.stub(:save).and_return(false)
# #         put :update, {:id => entity.to_param, :entity => {}}, valid_session
# #         response.should render_template("edit")
# #       end
# #     end
# #   end
# # 
# #   describe "DELETE destroy" do
# #     it "destroys the requested entity" do
# #       entity = Entity.create! valid_attributes
# #       expect {
# #         delete :destroy, {:id => entity.to_param}, valid_session
# #       }.to change(Entity, :count).by(-1)
# #     end
# # 
# #     it "redirects to the entities list" do
# #       entity = Entity.create! valid_attributes
# #       delete :destroy, {:id => entity.to_param}, valid_session
# #       response.should redirect_to(entities_url)
# #     end
# #   end
# # 
# end
