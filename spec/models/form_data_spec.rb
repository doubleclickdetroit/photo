require 'spec_helper'

describe FormData do
  before(:each) do
    @form      = Factory(:form)
    @form_data = Factory(:form_data)
    @form.form_data = @form_data
  end

  describe '#entity' do
    it 'should return the associated Form' do
      @form_data.entity.should be_a_kind_of(Form)
      @form_data.entity.should == @form
    end
  end
  
  describe '#data' do
    it 'should return a Hash' do
      @form_data.data.should be_a_kind_of(Hash)
    end

    it 'should contain certain keys...'
  end
end
