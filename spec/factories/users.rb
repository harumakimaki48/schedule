FactoryBot.define do
  factory :user do
    sequence(:user_number) { |n| "user_#{n}" }
    user_name { "Test User" }
    password { "password" }
    password_confirmation { "password" }
    role { :user }
    end
  end
