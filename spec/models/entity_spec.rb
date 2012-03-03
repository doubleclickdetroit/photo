require 'spec_helper'

describe Entity do
  before(:each) do
    @user = Factory(:user)
    @project = Factory(:project)
    @entity = Factory(:entity)
  end

  # describe '#group' do
  # # delegated to #project
  # end

  # provided by ActiveRecord
  describe '#project=/project' do
    it 'should save a project' do
      @entity.project = @project
      @entity.project.should == @project
    end
  end

  # provided by ActiveRecord
  describe '#followers' do
    before(:each) do
      @entity = Factory(:entity)
      @user1 = Factory(:user)
      @entity.followers << @user
      @entity.followers << @user1
    end

    it 'should return an Array of Users' do
      @entity.followers.all{|e| e.is_a? User }.should be_true
    end
  end

  describe '#assign_to(/#assignee)' do
    it 'should assign the task to a User' do
      @entity.assign_to @user
      @entity.assignee.should == @user
    end
  end

  describe '#assign' do
    it 'should return nil when no user is assigned' do
      @entity.assign_to @user
      @entity.assignee.should == @user
    end
  end

  describe '#unassign!' do
    it 'should unassign the entity' do
      @entity.assign_to @user
      @entity.unassign!
      @entity.assignee.should be_nil
    end
  end

  # describe '#assignee' do
  # end
end
