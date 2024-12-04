FactoryBot.define do
    factory :payment do
        amount { 1000 }
        content { "Test Payment" }
        date { Date.today }
        payment_date { Date.today }
        association :user
        association :recipient, factory: :user
        association :room
    end
  end
