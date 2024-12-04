FactoryBot.define do
    factory :schedule do
      content { "Test Schedule" }
      selected_date { Date.today }
      time_start { "10:00" }
      time_end { "12:00" }
      association :room
    end
  end
