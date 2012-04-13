require 'spec_helper'

describe Form do
  before(:each) do
    @form      = Factory(:form, :with_association)
    @form_type = @form.form_type
    @form_data = @form.form_data
  end

  pending 'sanitize inputs'

  describe '.form_hash' do
    it 'should return the result of its FormType and FormData' do
      hash = @form.form_hash
      hash.should == @form.form_type.to_hash(@form.form_data)
    end
  end

  describe '.to_hash' do
    pending 'there should probably be more tests here but i
    doubt im going to be able to think them all up right now'

    it 'should call .form_hash' do
      @form.stub(:simple_hash).and_return({})
      @form.should_receive :form_hash
      @form.to_hash
    end
  end

  describe 'associated model' do
    it 'FormData should be destroyed on Form#destroy' do
      expect {
        @form.destroy
      }.to change(FormData,:count).by(-1)
    end

    it 'FormType should NOT be destroyed on Form#destroy' do
      expect {
        @form.destroy
      }.to change(FormType,:count).by(0)
    end
  end

end
