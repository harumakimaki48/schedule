FactoryBot.define do
  factory :user do
    sequence(:user_number) { |n| "12345#{n}" } # 一意なuser_numberを生成
    user_name { "Test User" }
    password { "password" }
    password_confirmation { "password" }
    role { :user }
    end
  end
