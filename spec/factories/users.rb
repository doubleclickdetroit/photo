include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:first) {|n|"Foo#{n}"}
    sequence(:last) {|n|"Bar#{n}"}

    sequence(:email) {|n|"foo#{n}@bar.com"}

    password "foobarbaz"
    password_confirmation {|u| u.password}

    trait :with_avatar do
      avatar fixture_file_upload(Rails.root.join('app','assets','images','avatar.png'), 'image/png')
    end
  end
end
