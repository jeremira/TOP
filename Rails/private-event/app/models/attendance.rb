class Attendance < ApplicationRecord
	belongs_to :attendee,		:class_name => "User"
	belongs_to :event_attented,  :class_name => "Event"
end
