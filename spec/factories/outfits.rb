FactoryBot.define do
    factory :outfit do
      name { "Casual Outfit" } # 必須属性として設定
      association :user
      association :room

      after(:build) do |outfit|
        outfit.headband_image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'headband.jpg')),
          filename: 'headband.jpg',
          content_type: 'image/jpg'
        )
        outfit.clothing_image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'clothing.jpg')),
          filename: 'clothing.jpg',
          content_type: 'image/jpg'
        )
        outfit.bag_image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'bag.jpg')),
          filename: 'bag.jpg',
          content_type: 'image/jpg'
        )
        outfit.shoes_image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'shoes.jpg')),
          filename: 'shoes.jpg',
          content_type: 'image/jpg'
        )
      end
    end
  end
