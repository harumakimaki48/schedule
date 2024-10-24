class Area < ApplicationRecord
    has_many :shops, dependent: :destroy
    belongs_to :park
end
