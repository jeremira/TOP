class Book

	attr_accessor :title

	def title
		#@title = @title.capitalize
		#@title.split.map(&:capitalize).join(' ')
		#@title.split.map do |i| 
		#
		#					if (i != "the") && (i != "a") && (i != "an") && (i != "and") && (i != "in") && (i != "of")
		#					i.capitalize 
		#					else i
		#					end
		#	
		#			end.join(" ")
		array = []
		@title.split.each do |i|
			if (i != "the") && (i != "a") && (i != "an") && (i != "and") && (i != "in") && (i != "of")
			array << i.capitalize 
			else array << i
			end
		end
		array[0] = array[0].capitalize
		@title = array.join(" ")
			
		
	end

end
