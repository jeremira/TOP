class Background < ApplicationRecord
	has_many :findables
	has_many :characters, :through => :findables
end
