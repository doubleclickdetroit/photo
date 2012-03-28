include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :invitation do
    sequence(:first) {|n|"InviteeFirst#{n}"}
    sequence(:last) {|n|"InviteeLast#{n}"}
    sequence(:email) {|n|"invitee#{n}@example.com"}

    group_id nil
    inviter_id nil
    message "Invitation message text"

    trait(:with_inviter) do
      inviter { Factory(:user) }
    end

    trait(:with_group) do
      group { Factory(:group) }
    end
  end
end
