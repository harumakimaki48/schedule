FactoryBot.define do
    factory :user do
      user_number { "12345" }
      user_name { "Test User" }
      password { "password" }
      password_confirmation { "password" }
      role { :user }
    end
  end
