FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@weblinc.com" }
    password "weblinc"
    password_confirmation "weblinc"
  end
end
