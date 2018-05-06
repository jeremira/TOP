class Passenger < ApplicationRecord
	has_many :bookerings
	has_many :booking, through: :bookerings
end
