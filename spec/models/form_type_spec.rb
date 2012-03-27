require 'spec_helper'

describe FormType do
  # moved this to SerializedJSON
  before(:each) do
    @form      = Factory(:form)
    @form_type = Factory(:form_type)
    @form_data = Factory(:form_data)
    @form.form_type = @form_type
    @form.form_data = @form_data
  end

  describe '#entity' do
    it 'should return the associated Form' do
      @form_type.entity.should == @form
    end
  end

  describe '#to_hash' do
    it 'should simply return #data if no arg is provided' do
      @form_type.to_hash.should == @form_type.data
    end

    it 'should add values if FormData is passed in' do
      form_type = @form_type.to_hash(@form_data)
      form_data = @form_data.data

      all_have_key_value = true
      form_type['form'].each do |section_name,fields|
        fields.each do |field_name,pairs|
          all_have_key_value = false unless pairs.has_key?('value')
        end
      end
      all_have_key_value.should be_true
    end
  end

end
