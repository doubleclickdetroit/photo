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

  describe '#avatar' do
    describe '#url' do
      describe 'is not defined' do
        it 'should default to the default 30x30 when passed :icon' do
          @user.avatar.url(:icon).should == "/images/default_icon_avatar.png"
        end

        it 'should default to the default 100x100 when passed :small' do
          @user.avatar.url(:small).should == "/images/default_small_avatar.png"
        end
      end

      describe 'is defined' do
        before(:each) do
          @user = Factory(:user, :with_avatar)
        end

        it 'should return a URL for an icon when passed :icon' do
          @user.avatar.url(:icon).should match('icon')
        end

        it 'should return a URL for a small image when passed :small' do
          @user.avatar.url(:small).should match('small')
        end
      end
    end
  end
end
