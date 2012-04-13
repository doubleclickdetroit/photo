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

  describe '#spawn' do
    Entity::TYPES.each do |klass|
      it "should return a #{klass.to_s} for :type => '#{klass.to_s}'" do
        entity = Entity.spawn(:type => klass.to_s)
        entity.should be_an_instance_of(klass)
      end
        
      it "should set attributes of the #{klass.to_s} from the passed in Hash" do
        title = "Title for #{klass.to_s} from #{__FILE__}"
        entity = Entity.spawn({:type => klass.to_s, :title => title})
        entity.title.should == title
      end
    end
  end

  describe '#group' do
    it 'should be delegated to #phase' do
      @entity.phase = @phase
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

  describe '.simple_hash' do
    before(:each) { @entity.phase = Factory(:phase) }

    # todo should probably define these keys better
    keys = Entity.new.attributes.keys 
    keys << 'avatars'
    keys << 'phase'

    subject { @entity.simple_hash.keys }
    keys.each do |key|
      it { should include(key) }
    end

    it 'should not include any other keys' do
      simple_keys = @entity.simple_hash.keys
      anded_keys = keys & simple_keys
      simple_keys.should == anded_keys
    end
  end

  describe '#to_hash' do
    before(:each) { @entity.phase = (@phase = Factory(:phase)) }
    it 'should ensure no ruby objects are serialized' do
      pending 'entity.rb: hash[ass] = obj.is_a?(Array) ? obj.map(&:to_hash) : obj'
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
      describe "for subclass #{subclass.to_s}" do
        class_sym = subclass.to_s.downcase.intern
        attrs     = subclass.class_variable_get(:@@own_additional_attributes).sort

        attrs.each do |att|
          it "should have #{att.inspect} as a key" do
            @entity = Factory(class_sym, :with_association)
            @entity.phase = @phase
            @entity.to_hash.keys.should include(att.to_s)
          end
        end
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

  describe '.to_json' do
    it 'should call .simple_hash with no args' do
      @entity.should_receive :simple_hash
      @entity.should_not_receive :to_hash
      @entity.to_json
    end

    it 'should call .full_hash when passed true' do
      @entity.should_receive :to_hash
      @entity.to_json(true)
    end
  end
end
