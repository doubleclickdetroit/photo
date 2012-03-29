require 'spec_helper'

describe RegistrationForm do
  # # todo stash this somewhere sensical
  # before(:each) do
  #   @owner     = Factory(:user)
  #   # @admin     = Factory(:user)
  #   # @associate = Factory(:user)
  #   @group     = Factory(:group)
  #   # todo this in a factory
  #   @owner.enroll_in @group, :as => :owner
  #   # @admin.enroll_in @group, :as => :admin
  #   # @associate.enroll_in @group, :as => :associate
  # end

  describe '#generate_form_data_from' do
    let(:form) { FactoryGirl.create(:registration_form) }
    let(:invitation) { FactoryGirl.build(:invitation,:with_inviter,:with_group) }

    it 'should create one FormData' do
      expect {
        form.generate_form_data_from(invitation)
      }.to change(FormData, :count).by(1)
    end

    it 'should not create any FormTypes' do
      pending 'puts this where it belongs'
      expect {
        form.generate_form_data_from(invitation)
      }.to change(FormType, :count).by(0)
    end

    it 'should create the proper FormData' do
      pending 'again, stupid complicated to test...'
    end
  end
end

describe RegistrationForm.new.form_type do
  it { should be_a_kind_of(FormType) } 
  it { should be_a_new_record } # overrides AR
end
