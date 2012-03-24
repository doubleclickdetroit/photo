require 'spec_helper'

describe FormData do
  # moved this to SerializedJSON
  before(:each) do
    @form      = Factory(:form)
    @form_type = @form.form_type
    @form_data = @form.form_data
  end

  describe '#entity' do
    it 'should return the associated Form' do
      @form_data.entity.should == @form
    end
  end
  
end
