class Bookering < ApplicationRecord
	belongs_to :booking 
	belongs_to :passenger
end
