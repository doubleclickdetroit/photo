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

  describe '#created_by' do
    it 'should return a User (that created the Entity)' do
      @entity.created_by = @user
      @entity.created_by.should == @user
    end
  end

  describe '#updated_by' do
    it 'should return a User (that last updated the Entity)' do
      @entity.updated_by = @user
      @entity.updated_by.should == @user
    end
  end

  describe '#to_hash' do
    # Entity(id: integer, title: string, type: string, created_at: datetime, updated_at: datetime, project_id: integer, created_by_id: integer, updated_by_id: integer, text: text) 
    # comments, followers, assignee
    it 'should have all Entity attributes as keys' do
      attr_keys = @entity.attributes.keys
      hash_keys = @entity.to_hash.keys
      (attr_keys & hash_keys).should == attr_keys
    end

    it 'should have attributes of associated models' do
      pending 'these are currently [].to_s i think'
    end
  end
end
