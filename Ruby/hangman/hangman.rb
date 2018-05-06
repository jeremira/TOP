
class Hangman
	attr_reader :remaining_try, :game_over, :word_to_guess

	def initialize 
		@game_dico = []
		File.open("dico.txt", 'r').each do |line|
			@game_dico << line.downcase if ( line.length > 5 ) && ( line.length < 14 )
		end
		@word_to_guess = @game_dico.sample.chomp.split('')
		@remaining_try = 12
		@already_tried_letter = []
		@found_letter = []
		@game_over = "NOT_YET"
	end

	def ask_imput
		puts " ( Type SAVE to save the game, QUIT to return to the menu )"
		print ">>>>> Next letter to try ?   >  "
		bad_imput = true

		while bad_imput

		  @imput = gets.chomp.downcase
		  if @imput =~ /^[a-z]$/
		  	bad_imput = false
		   elsif @imput == "save"
		   	self.save_the_game
		   elsif @imput == "quit"
		   	 @game_over = "LOSS"
		   	 bad_imput = false
		   else 
		   	puts "Imput error : Enter one letter please"
		   end
		   puts ">>> Game saved <<<" if @imput == "save"
		   puts "Enter a letter to continue this game or type QUIT to return to the menu." if @imput == "save"
		end
		@imput
	end

	def next_turn

		if @word_to_guess.include?(@imput)
			@found_letter << @imput
			@present_or_not = " is part of the word ! Yeaaah !"
		else 
			@already_tried_letter << @imput
			@present_or_not = " is not in this word.... aaaaw."
		end

		@player_guessing =[]
		@word_to_guess.each do |letter|
			@player_guessing << letter if @found_letter.include?(letter)
			
			@player_guessing << "_" if !@found_letter.include?(letter)
			
		end
		print @player_guessing
		print @word_to_guess
		puts "-------------------------------------------------------------------"
		puts "|  Turn #{13 - @remaining_try} : Your ask for a  #{@imput.upcase} and it#{@present_or_not}"
		puts "|"
		puts "|        The word is : #{@player_guessing.join(" ").capitalize}"
		puts "|"
		puts "|  You have still #{@remaining_try} turn to guess right !"
		puts "|  Letter already tried : #{@already_tried_letter.join(" ").upcase}."
		puts "-------------------------------------------------------------------"
		
		@remaining_try -= 1

		if  @word_to_guess == @player_guessing
			@game_over = "WIN" 
			return
		elsif @remaining_try == 0
			@game_over = "LOSS"
		end

	end

	def save_the_game
		
		Dir.mkdir("save") unless Dir.exists? "save"

		puts "Enter filename"

		file_name = "save/#{gets.chomp.downcase}.txt"

		save_file = File.open(file_name,'w')
		  save_file.puts @word_to_guess.join
		  save_file.puts @remaining_try
		  save_file.puts @already_tried_letter.join
		  save_file.puts @found_letter.join
		save_file.close
	

		
		
	end

	def load_the_game

		puts "Name of file to load :"
		file_name = "save/#{gets.chomp.downcase}.txt"

		if File.exists? file_name 
		  load_file = File.open(file_name,'r')
		    @word_to_guess = load_file.gets.chomp.split('')
		    @remaining_try = load_file.gets.chomp.to_i
		    @already_tried_letter = load_file.gets.chomp.split('')
		    @found_letter = load_file.gets.chomp.split('')
		  load_file.close
		  puts "File #{file_name}.txt succesfully loaded !"
		self.one_game
		else 
			puts "Error file : #{file_name} not found"
		end
	end

	def one_game

		while @game_over == "NOT_YET"
			self.ask_imput
			self.next_turn if @imput =~ /^[a-z]$/ #quit to menu if not a letter
			
		end
		puts "Congratulation, you found the word : #{@word_to_guess.join.capitalize} in #{13 - @remaining_try} try !" if @game_over == "WIN"
		puts "Aww sorry, you could not find the word : #{@word_to_guess.join.capitalize}" if @game_over == "LOSS"
	end


end

	puts "-------------------------------------------------------------------"
	puts "-------------------------------------------------------------------"
	puts "-------------------------------------------------------------------"
	puts "-------------------------------------------------------------------"
 
my_game = Hangman.new
game_inprogress = true

while game_inprogress
	puts "-------------------------------------------------------------------"
	puts "Welcome in Hangman !"
	puts " At any moment in the game type SAVE to save the game, QUIT to exit the game"
	puts "   1. Launch a new game"
	puts "   2. Load saved game"
	puts "   3. Quit the programm"
	puts "-------------------------------------------------------------------"
	case menu_choice = gets.chomp.downcase
	when "1" then my_game.one_game
	when "2" then my_game.load_the_game
	when "3" then game_inprogress = false
	when "save" then puts "No game in progress, please start a game first."
	when "quit"	then game_inprogress = false
	end

end

	puts "Hangman game time is over. Have a good day !"

	puts "-------------------------------------------------------------------"
	puts "-------------------------------------------------------------------"
	puts "-------------------------------------------------------------------"
	puts "-------------------------------------------------------------------"
 


	





