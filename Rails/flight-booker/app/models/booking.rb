class Booking < ApplicationRecord
  belongs_to :flight
  has_many 	 :bookerings
  has_many 	 :passenger, through: :bookerings
  accepts_nested_attributes_for :passenger
end
