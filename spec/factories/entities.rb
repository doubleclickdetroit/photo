FactoryGirl.define do
  factory :entity do
    trait :with_comments do
      comments do
        [Factory(:comment)]*3
      end
    end

    trait :with_followers do
      followers do
        [Factory(:user)]*3
      end
    end

    trait :with_creator do
      created_by { Factory(:user) }
    end

    trait :with_updater do
      updated_by { Factory(:user) }
    end
  end

  ### subclasses ###
   
  factory :task, :parent => :entity, :class => "Task" do
    sequence(:title) {|n| "Task #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
    type "Task"

    trait :with_association do
      deadline { Factory(:deadline) }
      assignee { Factory(:user) }
    end
  end

  factory :event, :parent => :entity, :class => "Event" do
    sequence(:title) {|n| "Event #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
    type "Event"

    trait :with_association do
      duration { Factory(:duration) }
      location { Factory(:location) }
    end
  end

  factory :embed, :parent => :entity, :class => "Embed" do
    sequence(:title) {|n| "Embed #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
    type "Embed"

    trait :with_association do
      asset { Factory(:asset) }
    end
  end

  factory :form, :parent => :entity, :class => "Form" do
    sequence(:title) {|n| "Form #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
    type "Form"

    trait :with_association do
      form_type { Factory(:form_type) }
      form_data { Factory(:form_data) }
    end
  end

  factory :registration_form do
    sequence(:title) {|n| "RegistrationForm #{n}"}
    sequence(:text) {|n| "Lorem ipsum #{n}"}
    type "RegistrationForm"
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
