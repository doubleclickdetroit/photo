require 'spec_helper'

describe Form do
  before(:each) do
    @form      = Factory(:form, :with_association)
    @form_type = @form.form_type
    @form_data = @form.form_data
  end

  pending 'sanitize inputs'

  describe '#to_hash' do
    pending 'there should probably be more tests here but i
    doubt im going to be able to think them all up right now'

    it 'should pass #form_data to form_type#to_hash' do
      @form_type.should_receive(:to_hash).with(@form_data)
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
