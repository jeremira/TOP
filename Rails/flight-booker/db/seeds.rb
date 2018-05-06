# Airports
airport_codes = [ "CDG", "ORY", "TOU", "AMS", "LDN", "MDR", "ROM", "PLM", "FRK"]

airport_codes.each do |airport_code|
	Airport.create!( airport_code:  airport_code)
end

#Flights

rand_number = 102
airports 	= [1,2,3,4,5,6,7,8,9]
dates 		= [Time.new(2016, 8, 6,  14,  20,  0), Time.new(2016, 9, 5,  8,  20,  0), Time.new(2016, 10, 15,  16,  50,  0)]
durations 	= [3600, 7400, 7400*2, 3600/2+1200]
250.times do 
  Flight.create!( flight_number: 			"BF#{rand_number}",
				  departure_airport_id:  	airports.shuffle[0],
				  arrival_airport_id: 		airports.shuffle[0],
				  departure_time: 			dates.shuffle[0],
				  flight_duration: 			durations.shuffle[0])
  rand_number += airports.shuffle[0]
end

 Flight.create!(  flight_number: 			"BF666",
				  departure_airport_id:  	1,
				  arrival_airport_id: 		9,
				  departure_time: 			Time.new(2025, 9, 29,  14,  20,  0),
				  flight_duration: 			3600)

 Flight.create!(  flight_number: 			"BF000",
				  departure_airport_id:  	1,
				  arrival_airport_id: 		1,
				  departure_time: 			Time.new(2050, 1, 1,  00,  00,  0),
				  flight_duration: 			3600)