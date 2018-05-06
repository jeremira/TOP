require './lib/chess'

deck = Chess.new
puts ""
puts ""
puts "Welcome in Ubah chessator 3000X"
puts ""
game_over = false

until game_over
	deck.start_tour
	valid = false
	until valid
		deck.display_board
		imput = deck.ask_imput
		valid = deck.valid_move(imput)
		puts "Invalid Imput !" if valid == false
	end
	deck.play_turn(imput)
	echec = deck.check_check
	game_over = deck.check_mat if echec
end

puts "Ending....."
