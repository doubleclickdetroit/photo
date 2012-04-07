require 'spec_helper'

describe Entity do
  before(:each) do
    @user = Factory(:user)

    @project = Factory(:project)
    @phase   = Factory(:phase)

    # todo Entity must be of a subclass type
    # for #to_hash to function properly, Task
    # has been arbitrarily chosen here...
    # maybe change this?
    @entity = Factory(:task)
    @entity.deadline = Factory(:deadline)
  end

  # describe '#associate_asset' do
  #   it 'should be defined for all subclasses' do
  #     Entity::TYPES.each do |klass|
  #       klass.new.send(:associate_asset).should_not raise_error
  #     end
  #   end
  # end

  describe '#group' do
    it 'should be delegated to #phase' do
      @entity.phase.should_receive :group
      @entity.group
    end
  end

  describe '#project=/project' do
    it 'should let it belong_to a Project' do
      @entity.phase = @phase
      @entity.phase.should == @phase
    end
  end

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
    it 'should ensure no ruby objects are serialized' do
      pending 'entity.rb: hash[ass] = obj.is_a?(Array) ? obj.map(&:to_hash) : obj'
    end

    it 'should have all Entity attributes as keys' do
      attr_keys = @entity.attributes.keys
      hash_keys = @entity.to_hash.keys
      (attr_keys & hash_keys).should == attr_keys
    end

    it 'should contain avatars' do
      @entity.to_hash[:avatars].should be_a_kind_of(Array)
    end

    it 'should have attributes of associated models' do
      # check to make sure the vals for these keys
      # are Arrays of Hashes
      # keys = %w(comments followers)
      keys = Entity.class_variable_get(:@@super_additional_attributes).sort
      hash = @entity.to_hash
      all_hashes_in_array = keys.all? do |key|
        hash[key].all? do |array_item|
          array_item.is_a? Hash
        end
      end
      all_hashes_in_array.should be_true
    end

    Entity::TYPES.each do |subclass|
      class_sym = subclass.to_s.downcase.intern
      attrs     = subclass.class_variable_get(:@@own_additional_attributes).sort

      it "should have #{attrs.inspect} as keys for type:#{subclass.to_s}" do
        @entity = Factory(class_sym, :with_association)
        (@entity.to_hash.keys & attrs).sort.should == attrs.sort
      end
    end
  end

  describe '#display_date' do
    it 'should return start time for Event' do
      ent = Factory(:event, :with_association)
      ent.display_date.should == ent.start
    end

    it 'should return the due date for Task' do
      ent = Factory(:task, :with_association)
      ent.display_date.should == ent.due
    end

    it 'should return created_at for Embed' do
      ent = Factory(:embed, :with_association)
      ent.display_date.should == ent.created_at
    end
  end

  describe '#display_avatar' do
    it 'should return attendees urls and names for Event' do
      ent     = Factory(:event, :with_followers)
      avatars = ent.attendees.map {|a| {:id => a.id, :name => a.name, :icon => a.avatar.url(:icon)} }
      ent.display_avatars.should == avatars
    end

    it 'should return attendees urls and names for Task' do
      ent     = Factory(:task, :with_association)
      user    = ent.assignee
      avatars = [{:id => user.id, :name => user.name, :icon => user.avatar.url(:icon)}]
      ent.display_avatars.should == avatars
    end

    it 'should return attendees urls and names for Embed' do
      ent     = Factory(:embed, :with_creator)
      user    = ent.created_by
      avatars = [{:id => user.id, :name => user.name, :icon => user.avatar.url(:icon)}]
      ent.display_avatars.should == avatars
    end
  end

  describe '#to_json' do
    it 'should override #to_json, calling #to_hash' do
      @entity.should_receive :to_hash
      @entity.to_json
    end
  end
end
