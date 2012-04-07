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

  describe '#to_hash' do
    pending 'transition to phase'
    let(:hash) { @project.to_hash }

    it 'should contain the project #id and #name' do
      hash.has_key?('id').should be_true
      hash.has_key?('name').should be_true
    end

    it 'should call .to_hash on all associated Phases' do
      @project.phases << Factory(:phase) 
      @project.phases.each do |phase|
        phase.should_receive(:to_hash)
      end
      @project.to_hash
    end
  end

  describe '#to_json' do
    it 'should override to_json and call #to_hash' do
      @project.should_receive :to_hash
      @project.to_json
    end
  end

end
