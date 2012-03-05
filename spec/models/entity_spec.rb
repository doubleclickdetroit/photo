require 'spec_helper'

describe Entity do
  before(:each) do
    @user = Factory(:user)
    @project = Factory(:project)
    @entity = Factory(:entity)
  end

  describe '#group' do
    it 'should be delegated to #project' do
      @group = Factory(:group)
      @group.projects << @project
      @project.entities << @entity
      @entity.group.should == @project.group
    end
  end

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

  describe '#assignee =(/#assignee)' do
    it 'should assign the task to a User' do
      @entity.assignee = @user
      @entity.assignee.should == @user
    end
  end

  # todo not sure about this method
  describe '#unassign!' do
    it 'should unassign the entity' do
      @entity.assignee = @user
      @entity.unassign!
      @entity.assignee.should be_nil
    end
  end

  describe '#comments' do
    it 'should r/w and push comments' do
      @comment1,@comment2 = Factory(:comment),Factory(:comment)
      @entity.comments = [@comment1]
      @entity.comments << @comment2
      @entity.comments.should == [@comment1,@comment2]
    end
  end
end
