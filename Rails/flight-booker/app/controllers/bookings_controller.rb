class BookingsController < ApplicationController
  
  def new
  	@booking = Booking.new(booking_params)
  	@flight  = @booking.flight
  	@booking.passenger_number.times { @booking.passenger.build }
  end

  def create
  	@booking = Booking.new(booking_params)
  	if @booking.save
  	  redirect_to @booking
  	end 	
  end

  def show
  	@booking = Booking.find(params[:id])
  	@flight  = @booking.flight
  end

  private
  	def booking_params
  		params.require(:booking).permit(:passenger_number, :flight_id,
  										passenger_attributes: [:name, :email])
  	end
end
