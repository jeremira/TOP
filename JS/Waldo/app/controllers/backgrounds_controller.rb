class BackgroundsController < ApplicationController

	def index
		@backgrounds = Background.all
	end

	def show
		@background = Background.find_by_id(params[:id])
		@characters = @background.characters
    @jsonCharacters = []

		@characters.each do |char|
			findy = char.findables.where(background_id: @background.id).first
			@jsonCharacters.push({
				  id: char.id,
					name: char.name,
				  url: char.avatar,
				  locX: findy.locationX,
					locY: findy.locationY
				})
		end

	  respond_to do |format|
        format.html
        format.js
        format.json  { render json: @jsonCharacters }
      end
	end

end
