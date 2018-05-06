class Morpion
	attr_reader :winned_by, :not_yet_win

  def initialize #create morpion grid and 2 player
  	@player_1 = Player.new("Player 1", "X")
  	@player_2 = Player.new("Player 2", "O")
	$case_1 = Case.new(1,1)
	$case_2 = Case.new(1,2)
	$case_3 = Case.new(1,3)
	$case_4 = Case.new(2,1)
	$case_5 = Case.new(2,2)
	$case_6 = Case.new(2,3)
	$case_7 = Case.new(3,1)
	$case_8 = Case.new(3,2)
	$case_9 = Case.new(3,3)
	@not_yet_win = true
	@win_the_game = false
	  @winned_by = "SHOULD NOT APPEAR"
  end

  def display_grid #dysplay grid "O | X |  "
	puts " #{$case_1.checked_or_cricled} | #{$case_2.checked_or_cricled} | #{$case_3.checked_or_cricled}"
	puts "___________"
	puts " #{$case_4.checked_or_cricled} | #{$case_5.checked_or_cricled} | #{$case_6.checked_or_cricled}"
	puts "___________"
	puts " #{$case_7.checked_or_cricled} | #{$case_8.checked_or_cricled} | #{$case_9.checked_or_cricled}"
  end

  def game_over #update grid with player imput and check if win
    puts "#{@winned_player} win the game"
    self.display_grid
    puts "--------- Game over ---------"
  end

  def check_win #return false when game is won
  	@winned_by = @currently_playing

  	@not_yet_win = false if @win_the_game == true
  	
  end


  def next_turn #check which player is the trurn to play and call player imput
  	
  	if @player_1.my_turn
  		@currently_playing = "Player 1"
  		@player_1.player_play
  	else
  		@currently_playing = "Player 2"
  		@player_2.player_play
  	end

  	@player_1.my_turn = !@player_1.my_turn #invert who play next
  	@player_2.my_turn = !@player_2.my_turn

     case $case_played[0] # this case to check what is played
      when 1 then $case_1.checked = $case_played[1]
      when 2 then $case_2.checked = $case_played[1]
      when 3 then $case_3.checked = $case_played[1]
      when 4 then $case_4.checked = $case_played[1]
      when 5 then $case_5.checked = $case_played[1]
      when 6 then $case_6.checked = $case_played[1]
      when 7 then $case_7.checked = $case_played[1]
      when 8 then $case_8.checked = $case_played[1]
      when 9 then $case_9.checked = $case_played[1]
     end
 

   #check horizontal solution
    @win_the_game  = true if ($case_1.checked == $case_2.checked) && ($case_1.checked == $case_3.checked) && ($case_1.checked != " ")
    @win_the_game  = true if ($case_4.checked == $case_5.checked) && ($case_4.checked == $case_6.checked) && ($case_4.checked != " ")
    @win_the_game  = true if ($case_7.checked == $case_8.checked) && ($case_7.checked == $case_9.checked) && ($case_7.checked != " ")
   #check vertical solution
    @win_the_game  = true if ($case_1.checked == $case_4.checked) && ($case_4.checked == $case_7.checked) && ($case_1.checked != " ")
    @win_the_game  = true if ($case_2.checked == $case_5.checked) && ($case_2.checked == $case_8.checked) && ($case_2.checked != " ")
    @win_the_game  = true if ($case_3.checked == $case_6.checked) && ($case_3.checked == $case_9.checked) && ($case_3.checked != " ")
   #check diagonal solution
   	@win_the_game  = true if ($case_1.checked == $case_5.checked) && ($case_1.checked == $case_9.checked) && ($case_1.checked != " ")
    @win_the_game  = true if ($case_7.checked == $case_5.checked) && ($case_7.checked == $case_3.checked) && ($case_7.checked != " ")
    #process win or not

    self.check_win
      puts "........................................"
      self.display_grid

  end


    class Case
    	attr_accessor :checked, :already_checked
  
      def initialize(a,b)
        @checked = " "
        @already_checked = false
      end

    end


    class Player
    	attr_accessor :my_turn
    	@@played_imput = [ ]

      def initialize(name, symbol)
      	@name = name
      	@symbol = symbol
      	@symbol == "X" ? @my_turn = true : @my_turn = false #player 1 is givend X player 2 play with default O
      	
      end

      def player_play #imput from player who play
      	puts "#{@name}! What's your next move ? 1-9"
      	@invalid_imput = true
      	@imput = gets.chomp.to_i

      	while @invalid_imput 
      		if (1..9).include?(@imput)
      			if @@played_imput.include?(@imput) 
      				puts "Already played, choose another case"
      				@imput = gets.chomp.to_i
      			else 
      				@invalid_imput = false
      			end
      		else 
      			puts "Invalid imput, please choose a number between 1 and 9"
      			@imput = gets.chomp.to_i
      		end
      	end

      	@@played_imput << @imput 
      	$case_played = [@imput, @symbol] 

     end

    end

end

my_game = Morpion.new
puts "Starting game, see the grid below for later imput"
	puts " 1 | 2 | 3"
	puts "___________"
	puts " 4 | 5 | 6"
	puts "___________"
	puts " 7 | 8 | 9"
while my_game.not_yet_win
	my_game.next_turn
end
puts "---------------------------------------"
puts "         #{my_game.winned_by} win the game !"
puts "---------------------------------------"


  


