class Character < ApplicationRecord
	has_many :findables
	has_many :backgrounds, :through => :findables
end
