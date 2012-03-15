require 'spec_helper'

describe Entity do
  before(:each) do
    @user = Factory(:user)
    @project = Factory(:project)

    # todo Entity must be of a subclass type
    # for #to_hash to function properly, Task
    # has been arbitrarily chosen here...
    # maybe change this?
    @entity = Factory(:task)
    @entity.deadline = Factory(:deadline)
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
    it 'should have all Entity attributes as keys' do
      attr_keys = @entity.attributes.keys
      hash_keys = @entity.to_hash.keys
      (attr_keys & hash_keys).should == attr_keys
    end

    it 'should have attributes of associated models' do
      # check to make sure the vals for these keys
      # are Arrays of Hashes
      keys = %w(comments followers)
      hash = @entity.to_hash
      all_hashes_in_array = keys.all? do |key|
        hash[key].all? do |array_item|
          array_item.is_a? Hash
        end
      end
      all_hashes_in_array.should be_true
    end
  end
end
