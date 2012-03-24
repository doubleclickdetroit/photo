require 'spec_helper'

describe Form do
  before(:each) do
    @form      = Factory(:form)
    @form_data = Factory(:form_data)
    @form.form_data = @form_data
  end

  pending 'more thought on this'

  # describe '#data' do
  #   it 'should be delegated to #form_data' do
  #     hash = {'from' => 'spec/models/form_spec'}
  #     @form.data = hash 
  #     @form.data.should == hash
  #     @form_data.data.should == hash
  #   end
  # end
end
