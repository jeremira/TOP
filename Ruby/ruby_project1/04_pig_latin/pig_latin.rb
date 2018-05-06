
#string en array de mot
def translate (string)
	
	string_array = string.split
	
	string_array.each do |mot|
		piggy(mot)
	end

	string = string_array.join(" ")
	return string

end
	
#move consonne to the end + ay 
def piggy (word)

	#if word == word.capitalize
	#	capital = true
	#else capital = false
	#end

	#word = word.downcase

	while (word[0] != "a") && (word[0] != "e") && (word[0] != "i") && (word[0] != "o") && (word[0] != "u") 

		if word[0] == "q" && word[1] == "u"
				word << word[0]
				word << word[1]
				word[0] = ''
				word[0] = ''
		else
			word << word[0]
			word[0] = ''
		end	
	end

	word << "ay"

	#if 	capital == true
	#	word = word.capitalize
	#end

	return word

end