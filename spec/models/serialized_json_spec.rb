require 'spec_helper'

describe SerializedJSON do
  before(:each) do
    @sjson = Factory(:serialized_json)
  end

  describe '#data' do
    it 'should return a Hash' do
      @sjson.data.should be_a_kind_of(Hash)
    end
  end

end
