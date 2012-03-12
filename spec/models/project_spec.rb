require 'spec_helper'

describe Project do
  before(:each) { @project = Factory(:project) }

  describe '#timeline_json' do
  end

  describe '#entities_by_month_and_date' do
  end

  describe '#to_hash' do
    let(:hash) { @project.to_hash }

    it 'should contain the project #id and #name' do
      hash.has_key?('id').should be_true
      hash.has_key?('name').should be_true
    end
    
    # todo more of these tests...
  end
end
