require 'spec_helper'

describe Project do
  before(:each) { @project = Factory(:project) }

  describe '#group' do
    before(:each) { @project.group = Factory(:group) } 
    subject { @project.group }
    it { should be_a_kind_of(Group) }
  end

  describe '#timeline_json' do
    it "should dump the json equivalent of #to_hash"
  end

  describe '#phases' do
    before(:each) do
      @phase = Factory(:phase)
      @project.phases << @phase
    end

    it 'should contain an array of Phases' do
      @project.phases.should == [@phase]
    end
  end

  describe '.simple_hash' do
    let(:hash) do
      @project.group = Factory(:group)
      @project.phases = [Factory(:phase)]
      @project.simple_hash
    end

    it 'should contain the project #id and #name' do
      hash.has_key?('id').should be_true
      hash.has_key?('name').should be_true
    end

    it 'should call .simple_hash on all associated Phases' do
      @project.group = Factory(:group)
      @project.phases << Factory(:phase) 
      @project.phases.each do |phase|
        phase.should_receive(:simple_hash)
      end
      @project.simple_hash
    end
  end

  describe '.to_hash' do
    let(:hash) do
      @project.to_hash
    end
    
    pending 'needs more testing'

    it 'should call .to_hash on all associated Phases' do
      @project.group  = Factory(:group)
      @project.phases << Factory(:phase) 
      @project.phases.each do |phase|
        phase.should_receive(:to_hash)
      end
      @project.to_hash
    end
  end

  describe '.to_json' do
    it 'should call .simple_hash with no args' do
      @project.should_receive :simple_hash
      @project.should_not_receive :to_hash
      @project.to_json
    end

    it 'should call .full_hash when passed true' do
      @project.should_receive :to_hash
      @project.to_json(true)
    end
  end

end
