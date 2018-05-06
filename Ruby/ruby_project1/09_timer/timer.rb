class Timer

	attr_accessor :seconds

	def initialize
		@seconds = 0
	end

	def time_string
		@hour_timer = @seconds /3600  	
		@min_timer = ( @seconds - @hour_timer*3600 ) /60
		@sec_timer = @seconds - @hour_timer*3600 - @min_timer*60

		hour = "#{@hour_timer/10}#{@hour_timer-(@hour_timer/10)*10}"
		min = "#{@min_timer/10}#{@min_timer-(@min_timer/10)*10}"
		sec = "#{@sec_timer/10}#{@sec_timer-(@sec_timer/10)*10}"
		@time = "#{hour}:#{min}:#{sec}" 
	end

end
