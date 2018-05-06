def echo (imput)
	return imput.to_s
end

def shout (imput)
	return imput.to_s.upcase
end

def repeat ( imput , a = 2 )
	return ("#{imput} " * a).strip
end

def start_of_word ( imput , letter_amount )
	if letter_amount == 0
		return nil
	else
		array_imput = imput.chars.to_a
		result = array_imput[0]
		i = 1
			while i < letter_amount
				result = result + array_imput[i]
				i += 1
			end
	end
	return result
end

def first_word (imput)
	imput = imput.split.to_a
	return imput[0]
end

def titleize (imput)

imput = imput.split

result = []
	imput.each do |i|
		if i != "and" && i != "the" && i != "over"
			result << i.capitalize
		else 
		result << i 
		end
	end

if result[0] == "the"
	result[0] = "The"
end

return result.join(" ")

end




