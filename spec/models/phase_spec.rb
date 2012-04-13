require 'spec_helper'

describe Phase do
  before(:each) do
    @project = Factory(:project)
    @phase   = Factory(:phase)
    @project.phases << @phase
  end

  describe '.group' do
    it 'should be delegated to .project' do
      @phase.project.should_receive(:group)
      @phase.group
    end
  end

  describe '.project' do
    subject { @phase.project }
    it { should be_an_instance_of(Project) }
  end

  describe '#entities' do
    it 'should keep track of Entities' do
      @event = Factory(:event)
      @task  = Factory(:task)
      @embed = Factory(:embed)

      @phase.entities = [@event]
      @phase.entities << @task 
      @phase.entities << @embed 

      @phase.entities.should == [@event,@task,@embed]
    end
  end

  describe '.timeline_hash' do
    it "should simply call .entities_by_month_and_date" do
      @phase.stub(:entities_by_month_and_date)
      @phase.should_receive(:entities_by_month_and_date)
      @phase.timeline_hash
    end
  end

  describe '#entities_by_month_and_date' do
    it "should map the entities months/dates properly"
  end

  describe '.simple_hash' do
    before(:each) { @phase.project = Factory(:project) }

    # todo should probably define these keys better
    keys = Phase.new.attributes.keys

    subject { @phase.simple_hash }
    keys.each do |key|
      it { should include(key) }
    end

    it 'should not include any other keys' do
      simple_keys = @phase.simple_hash.keys
      anded_keys = keys & simple_keys
      simple_keys.should == anded_keys
    end
  end

  describe '.to_hash' do
    pending '...'
  end

  describe '.to_json' do
    it 'should call .simple_hash with no args' do
      @phase.should_receive :simple_hash
      @phase.should_not_receive :to_hash
      @phase.to_json
    end

    it 'should call .full_hash when passed true' do
      @phase.should_receive :to_hash
      @phase.to_json(true)
    end
  end

end
