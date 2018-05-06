require 'spec_helper'

describe Chess do 

	describe "#new" do 
		before :all do
		@chess = Chess.new
		end
		it "create a new board" do
			expect(@chess).to be_an_instance_of(Chess)
		end
		it "grid has 8x8 case" do
			expect(@chess.board.length).to be_eql (64)
		end
		it "random case in the middle have nil value" do
			ex = @chess.board.find { |hash| hash[:coord] == [2,5] }
			expect(ex[:piece]).to be_eql (nil)
		end

		it "random case in the middle have nil color" do
			ex = @chess.board.find { |hash| hash[:coord] == [5,3] }
			expect(ex[:color]).to be_eql (nil)
		end
		it "white tower has white tower value" do
			ex = @chess.board.find { |hash| hash[:coord] == [1,1] }
			expect(ex[:color]).to be_eql (:white)
			expect(ex[:piece]).to be_eql (:tour)
		end
		it "white king has white king value" do
			ex = @chess.board.find { |hash| hash[:coord] == [5,1] }
			expect(ex[:color]).to be_eql (:white)
			expect(ex[:piece]).to be_eql (:roi)
		end
		it "white pion has white pion value" do
			ex = @chess.board.find { |hash| hash[:coord] == [7,2] }
			expect(ex[:color]).to be_eql (:white)
			expect(ex[:piece]).to be_eql (:pion)
		end
		it "black cava has black cava value" do
			ex = @chess.board.find { |hash| hash[:coord] == [7,8] }
			expect(ex[:color]).to be_eql (:black)
			expect(ex[:piece]).to be_eql (:cava)
		end
		it "black king has black king value" do
			ex = @chess.board.find { |hash| hash[:coord] == [5,8] }
			expect(ex[:color]).to be_eql (:black)
			expect(ex[:piece]).to be_eql (:roi)
		end
		it "black pion has black pion value" do
			ex = @chess.board.find { |hash| hash[:coord] == [3,7] }
			expect(ex[:color]).to be_eql (:black)
			expect(ex[:piece]).to be_eql (:pion)
		end	
	end

	describe "#play_turn" do 
		before :all do
		@chess = Chess.new
		@chess.play_turn([[1,1],[8,8]])
		end
		it "clean piece value of previous place" do
			c = @chess.board.find { |hash| hash[:coord] == [1,1] }
			expect(c[:piece]).to be_eql(nil)
		end
		it "clean piece color of previous place" do
			c = @chess.board.find { |hash| hash[:coord] == [1,1] }
			expect(c[:color]).to be_eql(nil)
		end
		it "update piece value of new place" do
			c = @chess.board.find { |hash| hash[:coord] == [8,8] }
			expect(c[:piece]).to be_eql(:tour)
		end
		
	end

	describe "#valid_move" do 
		before :each do
		@chess = Chess.new
		@chess.start_tour
		end

		it "return false when depart is nil" do
			c = @chess.valid_move([[4,4],[1,1]])
			expect(c).to be_eql(false)
		end
		it "return false when arrive is nil" do
			c = @chess.valid_move([[1,1],[4,4]])
			expect(c).to be_eql(false)
		end
		it "return false when not a player piece" do
			c = @chess.valid_move([[1,7],[1,6]])
			expect(c).to be_eql(false)
		end
		it "return false when not a valid move for tour" do
			c = @chess.valid_move([[1,1],[1,2]])
			expect(c).to be_eql(false)
		end
		it "return false when not a valid move for cava" do
			@chess.play_turn([[2,1],[4,4]]) #met cava au millieu
			c = @chess.valid_move([[4,4],[3,3]])
			expect(c).to be_eql(false)
		end
		it "return false when not a valid move for fou" do
			@chess.play_turn([[3,1],[4,4]]) #met fou au millieu
			c = @chess.valid_move([[4,4],[4,8]])
			expect(c).to be_eql(false)
		end
		it "return false when not a valid move for reine" do
			@chess.play_turn([[4,1],[4,4]]) #met reine au millieu
			c = @chess.valid_move([[4,4],[1,8]])
			expect(c).to be_eql(false)
		end
		it "return false when not a valid move for roi" do
			c = @chess.valid_move([[5,4],[2,2]])
			expect(c).to be_eql(false)
		end
		it "return false when not a valid move for pion" do
			c = @chess.valid_move([[2,2],[2,6]])
			expect(c).to be_eql(false)
		end

		it "return true for a valid pion move" do
			c = @chess.valid_move([[1,2],[1,4]])
			expect(c).to be_eql(true)
		end
		it "return true for a valid pion move" do
			c = @chess.valid_move([[1,2],[1,3]])
			expect(c).to be_eql(true)
		end
		it "return true for a valid pion move" do
			@chess.start_tour
			@chess.play_turn([[1,8],[2,3]])
			@chess.start_tour
			c = @chess.valid_move([[1,2],[2,3]])
			expect(c).to be_eql(true)
		end
		it "return true for a valid tour move" do
			@chess.play_turn([[1,2],[4,4]])
			c = @chess.valid_move([[1,1],[1,4]])
			expect(c).to be_eql(true)
		end
		it "return false for a queen invalid move" do
			expect( @chess.valid_move([[4,1],[6,2]]) ).to be_eql(false)
		end
		it "return true for a queen valid move" do	
			@chess.play_turn([[4,1],[4,3]])
			expect(@chess.valid_move([[4,3],[4,5]])).to be_eql(true)
		end


		it "return false if white king try to move in a echec position" do	
			@chess.play_turn([[5,1],[4,4]])
			@chess.start_tour
			@chess.play_turn([[1,8],[1,5]])
			@chess.start_tour
			expect(@chess.valid_move([[4,4],[4,5]])).to be_eql(false)
		end

		it "return false if black king try to move in a echec position" do	
			@chess.play_turn([[3,2],[3,4]])
			@chess.start_tour
			@chess.play_turn([[5,8],[5,5]])
			expect(@chess.valid_move([[5,5],[4,5]])).to be_eql(false)
		end


	end

	describe "#check_check" do 
		before :each do
		@chess = Chess.new
		@chess.start_tour
		end

		it "return false when not Echec" do
			c = @chess.check_check
			expect(c).to be_eql(false)
		end
		it "return false whith king in the wild" do
			@chess.play_turn([[5,1],[7,4]])
			@chess.start_tour
			@chess.play_turn([[5,8],[2,5]])  # roi blanc en 7,4 et roi noir en 2,5
			c = @chess.check_check
			expect(c).to be_eql(false)
		end
			it "return false black king in the wild" do
			@chess.play_turn([[5,1],[7,4]])
			@chess.start_tour
			@chess.play_turn([[5,8],[2,5]])  # roi blanc en 7,4 et roi noir en 2,5
			@chess.start_tour
			c = @chess.check_check
			expect(c).to be_eql(false)
		end
		it "return true for black king threaten by tour" do
			@chess.play_turn([[5,1],[7,4]])
			@chess.start_tour
			@chess.play_turn([[5,8],[2,5]]) 
			@chess.start_tour
			@chess.play_turn([[1,1],[2,3]]) 
			c = @chess.check_check
			expect(c).to be_eql(true)
		end
		it "return true for black king threaten by cava" do
			@chess.play_turn([[5,1],[7,4]])
			@chess.start_tour
			@chess.play_turn([[5,8],[2,5]]) 
			@chess.start_tour
			@chess.play_turn([[2,1],[4,4]]) 
			c = @chess.check_check
			expect(c).to be_eql(true)
		end
		it "return true for black king threaten by queen" do
			@chess.play_turn([[4,1],[4,3]])
			@chess.start_tour
			@chess.play_turn([[5,8],[5,6]]) 
			@chess.start_tour
			@chess.play_turn([[4,3],[4,6]]) 
			c = @chess.check_check
			expect(c).to be_eql(true)
		end
		it "return true for white king threaten by pion" do
			@chess.play_turn([[5,1],[4,4]])
			@chess.start_tour
			@chess.play_turn([[3,7],[3,5]]) 
			c = @chess.check_check
			expect(c).to be_eql(true)
		end
		it "return true for white king threaten by queen" do
			@chess.play_turn([[5,1],[1,3]])
			@chess.start_tour
			@chess.play_turn([[4,8],[4,6]]) 
			c = @chess.check_check
			expect(c).to be_eql(true)
		end
		it "return true for white king threaten by fou" do
			@chess.play_turn([[5,1],[6,5]])
			@chess.start_tour
			@chess.play_turn([[3,8],[4,3]]) 
			c = @chess.check_check
			expect(c).to be_eql(true)
		end


	end


	describe "#check_mat" do 
		before :each do
		@chess = Chess.new
		@chess.start_tour
		end

		it "return false for new game board" do
			expect(@chess.check_mat).to be_eql(false)
		end

		it "return true for a check mate situation" do
			@chess.play_turn([[5,1],[4,6]])
			@chess.start_tour
			@chess.play_turn([[1,8],[1,5]])  
			@chess.start_tour
			expect(@chess.check_mat).to be_eql(true)
		end
	end

end