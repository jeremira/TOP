require 'spec_helper'

describe Puissance do 

	before :all do
		@grid = Puissance.new
	end

	describe "#new" do 
		it "create a new grid object" do
			expect(@grid).to be_an_instance_of(Puissance)
		end
		it "grid has 8x7=56 case" do
			expect(@grid.grid.length).to eql(56)
		end
		it "each case have a nil value" do
			@grid.grid.each { |c| expect(c[:value]).to eql(nil) }
		end
		it "each case have an 1 <= x position <= 7" do
			@grid.grid.each { |c| expect(c[:position][0]).to be_between(1,7).inclusive }
		end
		it "each case have an 1 <= y position <= 6" do
			@grid.grid.each { |c| expect(c[:position][1]).to be_between(1,6).inclusive }
		end

	
		
	end

end