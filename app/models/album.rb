class Album < ApplicationRecord
    validates :title, :year, :band_id, presence: true
    validates :live, inclusion: { in: [true, false] } # must have a boolean value of true or false

    belongs_to :band

    has_many :tracks, dependent: :destroy
end
