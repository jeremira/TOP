# foutrer tous les all move dans un required fichier
# a faire les check pour imput invalide
# a faire une confirmation apres le imput
# interdire les move qui se mettent en echec
#rajouter un imput forfait
# pion noir cant move 2 case

class Chess
	attr_accessor :player, :not_player, :win, :board, :turn
	def initialize
		@board = []

		@board << { :piece => :tour,  :color => :white,  :coord => [1,1] }
		@board << { :piece => :cava,  :color => :white,  :coord => [2,1] }
		@board << { :piece => :fou,   :color => :white,  :coord => [3,1] }
		@board << { :piece => :reine, :color => :white,  :coord => [4,1] }
		@board << { :piece => :roi,   :color => :white,  :coord => [5,1] }
		@board << { :piece => :fou,   :color => :white,  :coord => [6,1] }
		@board << { :piece => :cava,  :color => :white,  :coord => [7,1] }
		@board << { :piece => :tour,  :color => :white,  :coord => [8,1] }

		i = 0
		8.times do 
			i += 1
			@board << { :piece => :pion,  :color => :white,  :coord => [i,2] }
		end

		j = 2
		4.times do
			i = 0
			j += 1
			8.times do
				i += 1
				@board << { :piece => nil,  :color => nil,  :coord => [i,j] }
			end
		end

		i = 0
		8.times do 
			i += 1
			@board << { :piece => :pion,  :color => :black,  :coord => [i,7] }
		end

		@board << { :piece => :tour,  :color => :black,  :coord => [1,8] }
		@board << { :piece => :cava,  :color => :black,  :coord => [2,8] }
		@board << { :piece => :fou,   :color => :black,  :coord => [3,8] }
		@board << { :piece => :reine, :color => :black,  :coord => [4,8] }
		@board << { :piece => :roi,   :color => :black,  :coord => [5,8] }
		@board << { :piece => :fou,   :color => :black,  :coord => [6,8] }
		@board << { :piece => :cava,  :color => :black,  :coord => [7,8] }
		@board << { :piece => :tour,  :color => :black,  :coord => [8,8] }

		@win = false
		@player = :black
		@not_player = :white
		@turn = 0
	end

	def ask_imput
		
		array = []
		color = "blancs"  if @player == :white
		color = "noirs"   if @player == :black
		puts " -------------------------------------------- "
		puts " Tour : #{@turn} -- Les #{color} jouent !"
		puts " Case de départ (ex : 12 pour [1,2])"
		imput = gets.chomp.split("")
		array << imput.map { |n| n.to_i }
		puts " Case d'arrivé ? (ex : 12 pour [1,2])"
		imput = gets.chomp.split("")
		array  << imput.map { |n| n.to_i }
		return array
	end

	def start_tour
		#display fonction A FOUTRRE ICI ?
		@turn += 1
		@player, @not_player = @not_player, @player
	end

	def valid_move(move)

		depart = @board.find { |hash| hash[:coord] == move[0] }
	
		arrive = @board.find { |hash| hash[:coord] == move[1] }
		

		return false if depart == nil
		return false if depart[:piece] == nil 
		return false if depart[:color] != @player

		return false if arrive == nil
		case depart[:piece]
			when :tour
				all_move = move_tour(depart[:coord])
				return false unless all_move.include?(arrive[:coord]) 
			when :cava
				all_move = move_cava(depart[:coord])
				return false unless all_move.include?(arrive[:coord]) 
			when :reine
				all_move = move_reine(depart[:coord])
				return false unless all_move.include?(arrive[:coord]) 
			when :roi
				all_move = move_roi(depart[:coord])
				return false unless all_move.include?(arrive[:coord]) 
			when :fou
				all_move = move_fou(depart[:coord])
				return false unless all_move.include?(arrive[:coord]) 
			when :pion
				all_move = move_pion(depart[:coord])
				return false unless all_move.include?(arrive[:coord]) 
			end
		return true
	end


	def play_turn(move)
		depart = @board.find { |hash| hash[:coord] == move[0] }
		
		arrive = @board.find { |hash| hash[:coord] == move[1] }
		

		arrive[:piece] = depart[:piece]
		arrive[:color] = @player
		depart[:piece] = nil
		depart[:color] = nil
	end

	def check_check
		chek = @board.select { |hash| hash[:color] == @player }

		roi =  @board.find { |hash| hash[:piece] == :roi && hash[:color] == @not_player }
				
		chek.each do |hash|
			all_move = []
			case hash[:piece]
				when :tour
					move_tour(hash[:coord]).each { |e| all_move << e }
				when :cava
					move_cava(hash[:coord]).each { |e| all_move << e }
				when :fou
					move_fou(hash[:coord]).each { |e| all_move << e }
				when :reine
					move_reine(hash[:coord]).each { |e| all_move << e }
				when :pion
					move_pion(hash[:coord]).each { |e| all_move << e }
				end		
			puts "ECHEC !" if all_move.include?(roi[:coord])
			return true if all_move.include?(roi[:coord])
		end
		
		return false
	end

	def check_mat
		puts "DEBUG -- Cheking Mat ?"

		deck = @board.select { |hash| hash[:color] == @not_player }

		deck.each do |hash|
			all_move = [] 
			case hash[:piece]
				when :tour
					move_tour(hash[:coord]).each { |e| all_move << e }
				when :cava
					move_cava(hash[:coord]).each { |e| all_move << e }
				when :fou
					move_fou(hash[:coord]).each { |e| all_move << e }
				when :reine
					move_reine(hash[:coord]).each { |e| all_move << e }
				when :pion
					move_pion(hash[:coord]).each { |e| all_move << e }
				when :roi
					move_roi(hash[:coord]).each { |e| all_move << e }
			end

			all_move.each do |coord|
				result = fake_echec(hash[:coord], coord)
				return false if result == false
			end
		end
		puts "Should be mat !"
		return true
	end

	def unicode_chess(piece, color)
		if color == :white
			case piece
				when :roi
					return "\u2654"
				when :reine
					return "\u2655"
				when :tour
					return "\u2656"
				when :fou
					return "\u2657"
				when :cava
					return "\u2658"
				when :pion
					return "\u2659"
				else 
					return "ERROR DEBUG"
			end
		elsif color == :black
			case piece
				when :roi
					return "\u265A"
				when :reine
					return "\u265B"
				when :tour
					return "\u265C"
				when :fou
					return "\u265D"
				when :cava
					return "\u265E"
				when :pion
					return "\u265F"
				else 
					return "ERROR DEBUG"
			end
		else 
			return " "
		end
	end

	def display_board
		ligne_8 = @board.select { |h| h[:coord][1] == 8 }
		ligne_7 = @board.select { |h| h[:coord][1] == 7 }
		ligne_6 = @board.select { |h| h[:coord][1] == 6 }
		ligne_5 = @board.select { |h| h[:coord][1] == 5 }
		ligne_4 = @board.select { |h| h[:coord][1] == 4 }
		ligne_3 = @board.select { |h| h[:coord][1] == 3 }
		ligne_2 = @board.select { |h| h[:coord][1] == 2 }
		ligne_1 = @board.select { |h| h[:coord][1] == 1 }

		puts ""
		puts "   ----------------------------------------"
		print "   |"
		ligne_8.each do |hash|
			code = unicode_chess(hash[:piece], hash[:color])
			print " #{code}  |"
		end
		puts "   8"
		puts "   ----------------------------------------"
		print "   |"
		ligne_7.each do |hash|
			code = unicode_chess(hash[:piece], hash[:color])
			print " #{code}  |"
		end
		puts "   7"
		puts "   ----------------------------------------"
		print "   |"
		ligne_6.each do |hash|
			code = unicode_chess(hash[:piece], hash[:color])
			print " #{code}  |"
		end
		puts "   6"
		puts "   ----------------------------------------"
		print "   |"
		ligne_5.each do |hash|
			code = unicode_chess(hash[:piece], hash[:color])
			print " #{code}  |"
		end
		puts "   5"
		puts "   ----------------------------------------"
		print "   |"
		ligne_4.each do |hash|
			code = unicode_chess(hash[:piece], hash[:color])
			print " #{code}  |"
		end
		puts "   4"
		puts "   ----------------------------------------"
		print "   |"
		ligne_3.each do |hash|
			code = unicode_chess(hash[:piece], hash[:color])
			print " #{code}  |"
		end
		puts "   3"
		puts "   ----------------------------------------"
		print "   |"
		ligne_2.each do |hash|
			code = unicode_chess(hash[:piece], hash[:color])
			print " #{code}  |"
		end
		puts "   2"
		puts "   ----------------------------------------"
		print "   |"
		ligne_1.each do |hash|
			code = unicode_chess(hash[:piece], hash[:color])
			print " #{code}  |"
		end
		puts "   1"
		puts "   ----------------------------------------"
		puts ""
		print "     1  | 2  | 3  | 4  | 5  |  6  | 7  | 8"
		puts ""
		puts ""
	end


	def move_tour(depart)
		all_move = []

		x = depart[0]
		y = depart[1]
		loop do
			y += 1
			case_to_check = @board.find { |hash| hash[:coord] == [x, y] }
			if case_to_check == nil || case_to_check[:color] == @player
				break
			elsif case_to_check[:color] == @not_player
				all_move << case_to_check[:coord]
				break
			else
				all_move << case_to_check[:coord]
			end
		end

		x = depart[0]
		y = depart[1]
		loop do
			y -= 1
			case_to_check = @board.find { |hash| hash[:coord] == [x, y] }
			if case_to_check == nil || case_to_check[:color] == @player
				break
			elsif case_to_check[:color] == @not_player
				all_move << case_to_check[:coord]
				break
			else
				all_move << case_to_check[:coord]
			end
		end

		x = depart[0]
		y = depart[1]
		loop do
			x -= 1
			case_to_check = @board.find { |hash| hash[:coord] == [x, y] }
			if case_to_check == nil || case_to_check[:color] == @player
				break
			elsif case_to_check[:color] == @not_player
				all_move << case_to_check[:coord]
				break
			else
				all_move << case_to_check[:coord]
			end
		end

		x = depart[0]
		y = depart[1]
		loop do
			x += 1
			case_to_check = @board.find { |hash| hash[:coord] == [x, y] }
			if case_to_check == nil || case_to_check[:color] == @player
				break
			elsif case_to_check[:color] == @not_player
				all_move << case_to_check[:coord]
				break
			else
				all_move << case_to_check[:coord]
			end
		end
		return all_move


	end

	def move_cava(depart)
		all_move = []

		case_to_check = @board.find { |hash| hash[:coord] == [depart[0]+1, depart[1]+2] }
			all_move << case_to_check[:coord] if case_to_check != nil
		case_to_check = @board.find { |hash| hash[:coord] == [depart[0]+2, depart[1]+1] }
			all_move << case_to_check[:coord] if case_to_check != nil

		case_to_check = @board.find { |hash| hash[:coord] == [depart[0]+2, depart[1]-1] }
			all_move << case_to_check[:coord] if case_to_check != nil
		case_to_check = @board.find { |hash| hash[:coord] == [depart[0]+1, depart[1]-2] }
			all_move << case_to_check[:coord] if case_to_check != nil

		case_to_check = @board.find { |hash| hash[:coord] == [depart[0]-1, depart[1]-2] }
			all_move << case_to_check[:coord] if case_to_check != nil
		case_to_check = @board.find { |hash| hash[:coord] == [depart[0]-2, depart[1]-1] }
			all_move << case_to_check[:coord] if case_to_check != nil

		case_to_check = @board.find { |hash| hash[:coord] == [depart[0]-2, depart[1]+1] }
			all_move << case_to_check[:coord] if case_to_check != nil
		case_to_check = @board.find { |hash| hash[:coord] == [depart[0]-1, depart[1]+2] }
			all_move << case_to_check[:coord] if case_to_check != nil
		return all_move
	end

	def move_fou(depart)

		all_move = []

		x = depart[0]
		y = depart[1]
		loop do
			x += 1
			y += 1
			case_to_check = @board.find { |hash| hash[:coord] == [x, y] }
			if case_to_check == nil || case_to_check[:color] == @player
				break
			elsif case_to_check[:color] == @not_player
				all_move << case_to_check[:coord]
				break
			else
				all_move << case_to_check[:coord]
			end
		end

		x = depart[0]
		y = depart[1]
		loop do
			x -= 1
			y -= 1
			case_to_check = @board.find { |hash| hash[:coord] == [x, y] }
			if case_to_check == nil || case_to_check[:color] == @player
				break
			elsif case_to_check[:color] == @not_player
				all_move << case_to_check[:coord]
				break
			else
				all_move << case_to_check[:coord]
			end
		end

		x = depart[0]
		y = depart[1]
		loop do
			x += 1
			y -= 1
			case_to_check = @board.find { |hash| hash[:coord] == [x, y] }
			if case_to_check == nil || case_to_check[:color] == @player
				break
			elsif case_to_check[:color] == @not_player
				all_move << case_to_check[:coord]
				break
			else
				all_move << case_to_check[:coord]
			end
		end

		x = depart[0]
		y = depart[1]
		loop do
			x -= 1
			y += 1
			case_to_check = @board.find { |hash| hash[:coord] == [x, y] }
			if case_to_check == nil || case_to_check[:color] == @player
				break
			elsif case_to_check[:color] == @not_player
				all_move << case_to_check[:coord]
				break
			else
				all_move << case_to_check[:coord]
			end
		end
		return all_move

	end

	def move_reine(depart)
		all_move = []
		
		move_tour(depart).each { |coord| all_move << coord }
		
		move_fou(depart).each  { |coord| all_move << coord }

		return all_move
	end

	def fake_echec(depart,arrive) #coord
		#prend deux coordonne et fake un tour pour voir si ya echec ensuite
		#return true si echec dans la nouvelle case

		puts "DEBUG ERROR --  fake_echec dep" if depart == nil
		puts "DEBUG ERROR -- fake_echec arr" if arrive == nil
		
		save_depart =  @board.find { |hash| hash[:coord] == depart }
		save_dep_piece = save_depart[:piece]
		save_dep_color = save_depart[:color]
		save_arrive =  @board.find { |hash| hash[:coord] == arrive }
		save_arr_piece = save_arrive[:piece]
		save_arr_color = save_arrive[:color]
		
		play_turn([depart,arrive])
		
		@player, @not_player = @not_player, @player
		result_fake_echec = check_check
		@player, @not_player = @not_player, @player
		@board = @board.each do |hash| 
			if hash[:coord] == arrive 
				hash[:piece] = save_arr_piece
				hash[:color] = save_arr_color
			elsif hash[:coord] == depart 
				hash[:piece] = save_dep_piece
				hash[:color] = save_dep_color
			end  
  		end	

		return result_fake_echec
				
	end

	def move_roi(depart)
		#revamp ces spaguetti titi !
		all_move = []

		case_to_check =  @board.find { |hash| hash[:coord] == [depart[0], depart[1]+1] }
			
			if case_to_check != nil && case_to_check[:color] != @player
				result = fake_echec(depart, case_to_check[:coord])	
				all_move << case_to_check[:coord] if result == false
			end	

		case_to_check =  @board.find { |hash| hash[:coord] == [depart[0]+1, depart[1]+1] }
		
			if case_to_check != nil && case_to_check[:color] != @player
				result = fake_echec(depart, case_to_check[:coord])	
				all_move << case_to_check[:coord] if result == false
			end

		case_to_check =  @board.find { |hash| hash[:coord] == [depart[0]+1, depart[1]] }
	
			if case_to_check != nil && case_to_check[:color] != @player
				result = fake_echec(depart, case_to_check[:coord])	
				all_move << case_to_check[:coord] if result == false
			end
		
		case_to_check =  @board.find { |hash| hash[:coord] == [depart[0]+1, depart[1]-1] }
	
			if case_to_check != nil && case_to_check[:color] != @player
				result = fake_echec(depart, case_to_check[:coord])	
				all_move << case_to_check[:coord] if result == false
			end

		case_to_check =  @board.find { |hash| hash[:coord] == [depart[0], depart[1]-1] }
		
			if case_to_check != nil && case_to_check[:color] != @player
				result = fake_echec(depart, case_to_check[:coord])	
				all_move << case_to_check[:coord] if result == false
			end

		case_to_check =  @board.find { |hash| hash[:coord] == [depart[0]-1, depart[1]-1] }
	
			if case_to_check != nil && case_to_check[:color] != @player
				result = fake_echec(depart, case_to_check[:coord])	
				all_move << case_to_check[:coord] if result == false
			end

		case_to_check =  @board.find { |hash| hash[:coord] == [depart[0]-1, depart[1]] }
	
			if case_to_check != nil && case_to_check[:color] != @player
				result = fake_echec(depart, case_to_check[:coord])	
				all_move << case_to_check[:coord] if result == false
			end

		case_to_check =  @board.find { |hash| hash[:coord] == [depart[0]-1, depart[1]+1] }
		
			if case_to_check != nil && case_to_check[:color] != @player
				result = fake_echec(depart, case_to_check[:coord])	
				all_move << case_to_check[:coord] if result == false
			end
		return all_move
	end

	def move_pion(depart)
		all_move = []
		#re work pour match TRUE rules

		all_move << [ depart[0], depart[1]+2 ] if depart[1] == 2

		if @player == :white 

			case_to_check =  @board.find { |hash| hash[:coord] == [depart[0], depart[1]+1] }
			all_move << case_to_check[:coord] if case_to_check != nil && case_to_check[:color] != @player

			case_to_check = @board.find { |hash| hash[:coord] == [depart[0]-1, depart[1]+1] }
			all_move << case_to_check[:coord] if case_to_check != nil && case_to_check[:color] == @not_player

			case_to_check = @board.find { |hash| hash[:coord] == [depart[0]+1, depart[1]+1] }
			all_move << case_to_check[:coord] if case_to_check != nil && case_to_check[:color] == @not_player

		elsif @player == :black
			case_to_check =  @board.find { |hash| hash[:coord] == [depart[0], depart[1]-1] }
			all_move << case_to_check[:coord] if case_to_check != nil && case_to_check[:color] != @player

			case_to_check = @board.find { |hash| hash[:coord] == [depart[0]-1, depart[1]-1] }
			all_move << case_to_check[:coord] if case_to_check != nil && case_to_check[:color] == @not_player

			case_to_check = @board.find { |hash| hash[:coord] == [depart[0]+1, depart[1]-1] }
			all_move << case_to_check[:coord] if case_to_check != nil && case_to_check[:color] == @not_player
		else #should not occut
			puts "ERROR DEBUG -- move_pion "
		end


		return all_move
	end

end




	