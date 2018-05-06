def add( a , b )
	return ( a + b )
end



def subtract ( a , b )
	return ( a - b )
end



def sum ( a )
	total = 0

	if a == 0 
		 return a 
	else 
		a.each do |i|
			total += i
		end
	end
	return total	
end



def multiply ( *a  )

	total = 1

	if a.length == 1
		total = a[0]
	else
		a.each do |i|
			total = total * i
		end
	end
	return total
end


def factorial ( a )

	total = 1
	
	if a == 0
		total = 1
	
	else
		array = []
		pusher = 1
		while pusher <= a
			array << pusher
			pusher += 1
		end

		array.each do |i|
			total = total * i
		end
	end

	return total
end



def power ( a , b )
	return ( a ** b )
end
