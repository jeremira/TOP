require "csv"
require "sunlight/congress"
require "erb"
require 'date'

Sunlight::Congress.api_key ="e179a6973728c4dd3fb1204283aaccb5"
$counter = {:people => 0, :zipcode => 0, :tel => 0, :legislator => 0, :letter => 0, :date => 0}


def clean_zipcode(zipcode)
	$counter[:zipcode] += 1
	zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
	$counter[:legislator] += 1
	legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def invalid_phone #return array with 10 0
	@invalid_phone = []
	10.times { @invalid_phone << 0 }
	@invalid_phone
end


def clean_phone(phone_number)
	$counter[:tel] += 1
	@phone_number = phone_number.split('')
  	@phone_number = @phone_number.select { |char| char =~ /[0-9]/ }

	case 
		when @phone_number.length > 11 
			@phone_number = invalid_phone
		when @phone_number.length == 11
			@phone_number.shift if @phone_number.first == 1
			@phone_number = invalid_phone if  @phone_number.first != 1
		when @phone_number.length == 10 
			@phone_number
		else 
			@phone_number = invalid_phone
	end

	@phone_number_final = []

	@phone_number.each_with_index do |numero, index|
		@phone_number_final	<< "(" if index == 0		
		@phone_number_final	<< ")" if index == 3
		@phone_number_final	<< "-" if index == 6
		@phone_number_final	<< numero
	end

	@phone_number_final.join

end

def clean_register_time(time)
	$counter[:date] += 1
	@time = DateTime.strptime(time, '%m/%d/%Y %H:%M')
end

def save_letters(id, form_letter)
	$counter[:letter] += 1
	Dir.mkdir("output") unless Dir.exist? "output"

	filename = "output/thanks_#{id}.html"

	File.open(filename, 'w') do |file|
		file.puts form_letter
	end
end


puts "--------------------------------------------"
puts "  Event Managerator 3000X Initialized !!!!"
puts "  Please enjoy your database experience."
puts "--------------------------------------------"



contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
most_used_hour = {}
most_used_day = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0,}


contents.each do |row|
	puts ">>> Processing New Contact <<<  "
	id = row[0]
	$counter[:people] += 1
	print "#{id} : "

	name = row[:first_name]
	print "#{name} / "

	zipcode = clean_zipcode(row[:zipcode])
	print "zip : #{zipcode} / "

	phone_number = clean_phone(row[:homephone])
	puts "tel : #{phone_number}"

	print ".......Contacting server for Legislator Listing"
	legislators = legislators_by_zipcode(zipcode)
	puts "  /DONE/"

	print ".......Thanks letter creation"
	form_letter = erb_template.result(binding)
 	save_letters(id,form_letter)
 	puts "  /DONE/"	

	print ".......Updating Date&Time data for analyse"
	register_time = clean_register_time(row[:regdate])
	
	if most_used_hour[register_time.hour].nil?
		most_used_hour[register_time.hour] = 1 
	else
		most_used_hour[register_time.hour] += 1
	end

	most_used_day[register_time.wday] += 1

	puts "  /DONE"

end

hour_max = most_used_hour.key(most_used_hour.values.max)
day_max = most_used_day.key(most_used_day.values.max)
	case day_max
	when 0 then day_max = "Sunday"
	when 1 then day_max = "Monday"
	when 2 then day_max = "Tuesday"
	when 3 then day_max = "Wednesday"
	when 4 then day_max = "Thursday"
	when 5 then day_max = "Friday"
	when 6 then day_max = "Saturday"
	end

puts "---------------------------------------------------------------"
puts "---------------------------------------------------------------"
puts " >>>>>>>>> Pic Time for Registering "
puts "  #{hour_max} hour with #{most_used_hour.values.max} peoples." 
puts "  #{day_max} with #{most_used_day.values.max} peoples." 
puts " >>>>>>>>> Total Processed Data"
puts " Number of contact : #{$counter[:people]} | ZipCode cleaned : #{$counter[:zipcode]} | Phone Number cleaned : #{$counter[:tel]}"
puts " Letter created : #{$counter[:letter]}"
puts "---------------------------------------------------------------"
puts " CAUTION #{$counter[:people]} processed only #{$counter[:letter]} created." if $counter[:people] != $counter[:letter]
puts " NO ERROR DETECTED" if $counter[:people] == $counter[:letter]
puts "---------------------------------------------------------------"

puts "--------------------------------------------"
puts "  Event Managerator 3000X Terminated !!!!"
puts "   Hope you had a wonderfull experience."
puts "--------------------------------------------"