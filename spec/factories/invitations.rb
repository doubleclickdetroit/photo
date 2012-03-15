include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :invitation do
    sequence(:first) {|n|"InviteeFirst#{n}"}
    sequence(:last) {|n|"InviteeLast#{n}"}

    sequence(:email) {|n|"invitee#{n}@example.com"}

    group_id 1
    inviter_id 1
    message "Invitation message text"
  end
end
