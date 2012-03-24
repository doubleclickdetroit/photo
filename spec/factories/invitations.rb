include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :invitation do
    sequence(:first) {|n|"InviteeFirst#{n}"}
    sequence(:last) {|n|"InviteeLast#{n}"}
    sequence(:email) {|n|"invitee#{n}@example.com"}

    group_id nil
    inviter_id nil
    message "Invitation message text"
  end
end
