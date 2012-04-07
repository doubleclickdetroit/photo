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

  pending 'to_hash'
  pending 'to_json'

end
