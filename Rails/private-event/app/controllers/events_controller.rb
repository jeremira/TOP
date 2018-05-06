class EventsController < ApplicationController
  def new
  	@event = Event.new
  end

  def create
  	@event = current_user.events.build(event_params)
   	if @event.save
  		redirect_to current_user
  	else
  	 	render 'new'
  	end
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def index
    @upcoming_events = []
    @prev_events = []
    User.all.each do |user|
      @upcoming_events << upcoming_events(user)
      @prev_events     << prev_events(user)
    end
  end
  
  private
    def event_params
    	params.require(:event).permit(:name, :place, :moment)
    end
end
