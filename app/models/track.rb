class Track < ApplicationRecord
    validates :title, :ord, presence: true # :lyrics is optional
    validates :bonus, inclusion: { in: [true, false] }
    validates :ord, uniqueness: { scope: :album_id }

    belongs_to :album

    has_one :band,
        through: :album,
        source: :band
end
