class Song < ApplicationRecord
    validates :title, :artist_name, presence: true
    validates :released, inclusion: { in: [true, false]}
    validates :release_year, presence: true, if: :released?
    validates :title, uniqueness: { scope: :artist_name && :release_year,
        message: "Cannot be added by the same artist on the same year"}

    with_options if: :released? do |song|
        song.validates :release_year, presence: true , numericality: {less_than_or_equal_to: Date.today.year}
    end 

    def released?
        released 
    end 

end
