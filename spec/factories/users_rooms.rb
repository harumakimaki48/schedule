FactoryBot.define do
    factory :users_room do
      association :user
      association :room
    end
  end
