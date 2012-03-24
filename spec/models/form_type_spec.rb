require 'spec_helper'

describe FormType do
  # moved this to SerializedJSON
  before(:each) do
    @form      = Factory(:form)
    @form_type = @form.form_type
    @form_data = @form.form_data
  end

  describe '#entity' do
    it 'should return the associated Form' do
      @form_type.entity.should == @form
    end
  end

  describe '#to_hash' do
    it 'should call #data to build its return' do
      @form_type.should_receive :data
      @form_type.to_hash
    end

    it 'should dump vals from the form_data arg' do
      pending 'this is going to be stupid complicated to test...'
    end
  end

end
