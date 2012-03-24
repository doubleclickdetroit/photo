require 'spec_helper'

describe Form do
  before(:each) do
    @form      = Factory(:form)
    @form_data = @form.form_data
  end

  describe '#data/=' do
    it 'should be delegated to #form_data' do
      @form.form_data.should_receive :data
      @form.data
      @form.form_data.should_receive :data=
      @form.data = {}
    end
  end

  describe '#to_hash' do
    pending 'something tricksy'
  end

end
