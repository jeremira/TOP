module Mastermind
	$turn_counter = 0
	$all_try = {}
	$all_hint = {}
  class PlayerGame
  	attr_reader :secret_code
  	def initialize
  		#create secret code by pushing 4 random letter in the array
  		@secret_code = []
  		4.times { @secret_code << ['A', 'B', 'C', 'D', 'E', 'F'].sample }
  		puts "Secret code has been choosen ! Find the code in less than 12 try !"
  	end

  	def checkage
  		#generattion of hint code for this turn
  		@this_turn_hint = []
  		$all_try[$turn_counter].each_with_index do |n, i|
  			if  n ==  @secret_code[i]
  			  @this_turn_hint << "O" 
  			elsif @secret_code.include?(n)
  			  @this_turn_hint << "X" 
  			else
  			  @this_turn_hint << "." 
  			end
  		end
  		#push dans hash all hint
  		$all_hint[$turn_counter] = @this_turn_hint
  		puts "  >>>>  #{$all_try[$turn_counter].join(" ")}  <<<<>>>>  #{$all_hint[$turn_counter].join(" ")}  <<<<  "
  	end

  	def win_or_loss

		return "WON" if $all_hint[$turn_counter] == ["O","O","O","O"]
		return "LOSS" if $turn_counter == 12
  		return "not_win"
 	end

  	def next_turn
  		# call each turn, take imput, update all try hash
  		$turn_counter +=1
  		puts "Turn #{$turn_counter} : What's your guess ? (4 letter from A to F) "
  		@this_turn_try = gets.chomp.upcase.split("")
  		$all_try[$turn_counter] = @this_turn_try
  		
  	end

  end #Player game end

  class GameVsAi
  	attr_reader :secret_code

  	def initialize
  		puts "Choose a code : 4 letter between A and F (ex : ABFD)"
  		@secret_code = gets.chomp.upcase.split("")
  	end

  	def next_turn
  		$turn_counter +=1

  		if $turn_counter == 1
  			@this_turn_try = []
  			4.times { @this_turn_try << ['A', 'B', 'C', 'D', 'E', 'F'].sample }
  			@possible_letter = ['A', 'B', 'C', 'D', 'E', 'F']
  			@confirmed_letter = []
  		else
  			@array_previous_try = $all_try[$turn_counter - 1] #n-1 essai
  			@array_previous_hint = $all_hint[$turn_counter - 1] #n-1  hint
  			@this_turn_guess = ['X', 'X', 'X', 'X']
  			
  			@this_turn_try.each_with_index do |letter, index|
  				@this_turn_guess[index] = @this_turn_try[index] if @array_previous_hint[index] == "O"
  				@possible_letter.delete(letter)	if @array_previous_hint[index] == "."
  				@confirmed_letter << @this_turn_try[index] if (@array_previous_hint[index] == "X") && (@confirmed_letter.include?(@this_turn_try[index]))
  			end

  			@this_turn_guess.each_with_index do |letter, index|
  					if letter == "X"
  						if @confirmed_letter.length > 0
  							@this_turn_try[index] = @confirmed_letter.first
  							@confirmed_letter.shift
  						end
  						@this_turn_try[index] = @possible_letter.sample
  					end
  			end
  		end

  	

  		puts "Try #{$turn_counter} : Computer try #{@this_turn_try.join(" ")} "
  		$all_try[$turn_counter] = @this_turn_try
   	end #end next_turn

  	def checkage
  		#generattion of hint code for this turn
  		@this_turn_hint = []
  		$all_try[$turn_counter].each_with_index do |n, i|
  			if  n ==  @secret_code[i]
  			  @this_turn_hint << "O" 
  			elsif @secret_code.include?(n)
  			  @this_turn_hint << "X" 
  			else
  			  @this_turn_hint << "." 
  			end
  		end
  		#push dans hash all hint
  		$all_hint[$turn_counter] = @this_turn_hint
  		puts "  >>>>  #{$all_try[$turn_counter].join(" ")}  <<<<>>>>  #{$all_hint[$turn_counter].join(" ")}  <<<<  "
  	end #end checkage

  	def win_or_loss

		return "WON" if $all_hint[$turn_counter] == ["O","O","O","O"]
		return "LOSS" if $turn_counter == 12
  		return "not_win"

  	end

  end #GamevsAI end

  
end #module end

puts "                -- Mastermind -- "
puts "--------------------------------------------------------"
puts " Find the secret code of four letter from A to F"
puts " You have 12 try to guess the code."
puts " After each try, a hint is returned : "
puts "				O for a correct guess,"
puts "              X for a incorrect position,"
puts "              . for a non-present letter"
puts "--------------------------------------------------------"
puts " Choose your role ? 1 > guess the code | 2 > protect the code"


choice_imput = gets.chomp.to_i

my_game = Mastermind::PlayerGame.new if choice_imput == 1
my_game = Mastermind::GameVsAi.new if choice_imput == 2
puts "ERROR DEBUG BAD IMPUT" if (choice_imput != 1) && (choice_imput != 2) #creer une boucle ici juskque a avoir good imput
end_of_game = "not_win"

while end_of_game == "not_win"
  my_game.next_turn
  my_game.checkage
  end_of_game = my_game.win_or_loss
end
puts "--------------------------------------------------------"
puts " You found the secret code in #{$turn_counter} try !" if  end_of_game == "WON"
puts " You could not find the code in 12 try !" if  end_of_game == "LOSS"
puts " DEBUG SHOULD NOT APPEAR" if  end_of_game == "not_win"
puts "Secret code was : #{my_game.secret_code.join(" ")}."
puts "--------------------------------------------------------"

 #if 2 cest contre AI

#	- choose your code ? foutre ABCD dans larray
#	- AI guess 1
#	- player check le guess 1 et fait hint 1
#	- AI guess 2
#	- ...
#	- AI huess 12 > LOSS
#	- AI guess X == 0 0 0 0 > WIN 