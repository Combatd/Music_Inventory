class Track < ApplicationRecord
    validates :title, :ord, presence: true # :lyrics is optional
    validates :bonus, inclusion: { in: [true, false] }
    validates :ord, uniqueness: { scope: :album_id }
end
