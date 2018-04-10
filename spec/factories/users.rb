FactoryBot.define do
  factory :user do
    first_name "Aaron"
    last_name "Sumner"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "password"
  end
end
