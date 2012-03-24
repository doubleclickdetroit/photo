require 'spec_helper'

describe Form do
  before(:each) do
    @form      = Factory(:form)
    @form_type = @form.form_type
    @form_data = @form.form_data
  end

  describe '#to_hash' do
    pending 'something tricksy'
  end

end
