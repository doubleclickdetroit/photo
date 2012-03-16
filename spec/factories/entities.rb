FactoryGirl.define do
  factory :entity do
    sequence(:title) {|n| "Entity #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
  end

  # subclasses
  factory :task do
    sequence(:title) {|n| "Task #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
    type "Task"

    trait :with_association do
      deadline { Factory(:deadline) }
    end
  end

  factory :event do
    sequence(:title) {|n| "Event #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
    type "Event"

    trait :with_association do
      time_place { Factory(:time_place) }
    end
  end

  factory :embed do
    sequence(:title) {|n| "Embed #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
    type "Embed"

    trait :with_association do
      asset { Factory(:asset) }
    end
  end

  factory :form do
    sequence(:title) {|n| "Form #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
    type "Form"

    trait :with_association do
      form_data { Factory(:form_data) }
    end
  end
end

# Factory.define :milestone do |f|
#   f.sequence(:title) {|n| "Milestone #{n}"}
#   f.sequence(:text) {|n| "Lorem ipsum #{n}"}
#   f.type "Milestone"
# end
# 
# Factory.define :suggestion do |f|
#   f.sequence(:title) {|n| "Suggestion #{n}"}
#   f.sequence(:text) {|n| "Lorem ipsum #{n}"}
#   f.type "Suggestion"
# end
# 
# Factory.define :correspondence do |f|
#   f.sequence(:title) {|n| "Correspondence #{n}"}
#   f.sequence(:text) {|n| "Lorem ipsum #{n}"}
#   f.type "Correspondence"
# end
