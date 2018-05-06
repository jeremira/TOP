class FlightsController < ApplicationController

  def index
  	@booking = Booking.new
    @departure_airports_options = Airport.all.map { |a| [a.airport_code, a.id] }

	  @arrival_airports_options   = Airport.all.map { |a| [a.airport_code, a.id] }

    @flight_dates_options 	    = Flight.all.map  { |f| f.departure_time }
    @flight_dates_options.uniq!
    @flight_dates_options.map!	{ |date| [date.to_datetime.strftime("%m/%d/%Y"),date] }


    if params[:departure_airport_id]
	  @flights    = Flight.where("departure_airport_id = ? AND arrival_airport_id = ? AND departure_time = ?",
				    params[:departure_airport_id], params[:arrival_airport_id], params[:flight_date].to_datetime)
	  @departure  = Airport.find(params[:departure_airport_id].to_i)
	  @arrival    = Airport.find(params[:arrival_airport_id].to_i)
    end
  end
end
