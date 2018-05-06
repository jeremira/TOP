class Event < ApplicationRecord
  belongs_to :user
  has_many 	 :attendances, foreign_key: :event_attented_id
  has_many	 :attendee, through: :attendances
end
