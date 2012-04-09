require 'spec_helper'

describe PhasesController do
  attr_accessor :valid_attributes, :valid_session

  context 'admin logged in' do
    login_admin_and_populate_projects_and_entities()

    describe 'authorization' do
      before(:each) do
        phase = Factory.build(:phase)
        @params = {
          phase:   phase,
          project_id: @project.to_param 
        }
        @session = valid_session
      end
      # it_should_check_permissions(@params, @session, :update, :destroy)
    end

    # describe 'GET index' do
    #   it 'should call Phase.by_project(param[:project_id])' do
    #     project_id = '1'
    #     Phase.should_receive(:by_project).with(project_id)
    #     get :index, { :project_id => project_id }
    #   end
    # end

    # describe 'GET show' do
    #   it 'should call Phase.find(param[:id])' do
    #     pending 'receiving message twice...'
    #     id = '1'
    #     Phase.should_receive(:find).with(id)
    #     get :show, { :id => id }
    #   end
    # end

    # describe "POST create" do
    #   it "should throw an error if no project_id" do
    #     post :create, { :phase => {} }, valid_session
    #     response.status.should == 406
    #   end

    #   it "should create a Phase" do
    #     phase = Factory.build(:phase)
    #     expect{
    #       post :create, {:project_id => @project.to_param, :phase => phase.attributes}, valid_session
    #     }.to change(Phase, :count).by(1)
    #   end
    # end

    # describe "PUT update" do
    #   it "should call Phase#update_attributes" do
    #     phase = Factory(:phase)
    #     @project.phases << phase
    #     Phase.any_instance.should_receive :update
    #     put :update, {:id => phase.to_param, :phase => {:name => 'PUT update'}}, valid_session
    #   end
    # end

    # describe "DELETE destroy" do
    #   it "destroy the Phase" do
    #     phase = Factory(:phase)
    #     @project.phases << phase
    #     expect{
    #       delete :destroy, {:id => phase.to_param}, valid_session
    #     }.to change(Phase, :count).by(-1)
    #   end
    # end

  end

end
