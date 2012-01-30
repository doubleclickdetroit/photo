# Factory.define :user do |f|
#   f.sequence(:name) {|n| "foo#{n}"}
# end

FactoryGirl.define do
  factory :group do
    sequence(:name) {|n| "Group #{n}"}
  end
end
