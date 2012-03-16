require 'spec_helper'

describe Form do
  before(:each) do
    @form      = Factory(:form)
    @form_data = Factory(:form_data)
    @form.form_data = @form_data
  end

  describe '#data' do
    it 'should be delegated to #form_data' do
      @form.data = {:from => 'spec/models/form_spec'}
      @form.data.should == @form_data.data
    end
  end
end
