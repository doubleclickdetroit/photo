require 'spec_helper'

describe Form do
  before(:each) do
    @form      = Factory(:form)
    @form_type = @form.form_type
    @form_data = @form.form_data
  end

  describe '#to_hash' do
    pending 'there should probably be more tests here but i
    doubt im going to be able to think them all up right now'

    it 'should pass #form_data to form_type#to_hash' do
      pending 'some stupid nil thing'
      # @form_type.should_receive(:to_hash).with(@form_data)
      # @form.to_hash
    end
  end

end
