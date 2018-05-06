class User < ApplicationRecord
	has_many  :events
	has_many  :attendances, foreign_key: :attendee_id
	has_many  :event_attented, :through => :attendances

end
