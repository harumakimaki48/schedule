FactoryBot.define do
    factory :room do
        sequence(:room_number) { |n| "123456#{n}" } # 一意なroom_numberを生成
        password { "password123" }
        date_start { Date.today }
        date_end { Date.today + 7 }
        association :user
    end
  end
