# Over-commented code to step through and ensure I obtained a strong grasp of concepts 
# Imports
require 'date'
require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

# Define a method to clean the input zip code
def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4] # Convert to string, fill with leading zeros, and slice to 5 digits
end

# Define a method to find legislators by zip code
def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new # Create a new instance of Google Civic Information API
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw' # API key

  begin # Start a try-catch block
    civic_info.representative_info_by_address( # Call the method representative_info_by_address of civic_info object
      address: zip, # The zip code to search
      levels: 'country', # Restrict the search to the country level
      roles: ['legislatorUpperBody', 'legislatorLowerBody'] # Filter for legislators
    ).officials # Return the list of officials
  rescue # Catch exceptions
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials' # Return the error message
  end
end

# Define a method to save the thank you letter in a file
def save_thank_you_letter(id,form_letter)
  Dir.mkdir('outputs') unless Dir.exist?('outputs') # Create the outputs folder if it doesn't exist

  filename = "outputs/thanks_#{id}.html" # Define the file name based on the attendee ID

  File.open(filename, 'w') do |file| # Open the file in write mode
    file.puts form_letter # Write the thank you letter
  end
end

# Define a method to format the phone number
def format_phone_number(phone_number) 
  phone_number.gsub!(/\D/, '') # Remove all non-digit characters
  if phone_number.length == 10 # If the phone number has 10 digits
    "#{phone_number[0..2]}-#{phone_number[3..5]}-#{phone_number[6..9]}" # Format as xxx-xxx-xxxx
  elsif phone_number.length == 11 && phone_number[0] == '1' # If the phone number has 11 digits and starts with 1
    "#{phone_number[1..3]}-#{phone_number[4..6]}-#{phone_number[7..10]}" # Format as xxx-xxx-xxxx
  else
    'Incorrect Number Format!' # Return an error message if 11 digits but 1st is not 1 or more than 11 digits
  end
end

# Define a method to count the frequency of elements in an array
def count_frequency(array) 
 array.max_by {|a| array.count(a)} # Return the element with the maximum frequency
end

# Define an array with the names of the hours of the day
HOURNAMES = [ 
  "12 am", "1 am", "2 am", "3 am", "4 am", "5 am", "6 am", "7 am", 
  "8 am", "9 am", "10 am", "11 am", "12 pm", "1 pm", "2 pm", "3 pm", 
  "4 pm", "5 pm", "6 pm", "7 pm", "8 pm", "9 pm", "10 pm", "11 pm"
]

# This method takes a number and returns a string indicating the time of day it represents.
def convert_to_time_of_day(num)
  HOURNAMES[num % 24]
end

# Open the CSV file containing the event attendees list and specify that the first line contains headers
contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

# Get the number of lines in the CSV file
contents_size = CSV.read('event_attendees.csv').length
# Decrease the number of lines by 1 to exclude the headers line
contents_size-=1

# Load the content of a form letter file into a variable
template_letter = File.read('form_letter.erb')
# Create a new ERB object using the form letter content
erb_template = ERB.new template_letter

# Create two arrays to store the hour of the day and the day of the week of each attendee registration
hour_of_day = Array.new(contents_size)
day_of_week = Array.new(contents_size)
# Create a counter variable
n=0

# Iterate through each line of the CSV file
contents.each do |row|

  # Extract some information about the attendee from the CSV file
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode]) # this method ensures that zip codes are in the proper format
  legislators = legislators_by_zipcode(zipcode) # this method finds the legislators for a given zip code
  reg_date = row[:regdate]
  unformatted_numbers = row[:homephone]
  formatted_numbers = format_phone_number(row[:homephone]) # this method formats phone numbers in a consistent way

  # Print a progress bar indicating the percentage of attendees processed so far
  ouput = ((id.to_f/contents_size)*100)
  print "."
  sleep(0.2)
  print "."
  sleep(0.2)
  print "."
  sleep(0.2)
  print "#{(ouput / 5.0).round * 5}%\n"
  
  # Convert the attendee registration date into a DateTime object and extract the hour of the day and the day of the week
  reg_date_to_print = DateTime.strptime(reg_date,"%m/%d/%y %H:%M")
  hour_of_day[n] = reg_date_to_print.hour
  day_of_week[n] = Date::DAYNAMES[reg_date_to_print.wday]
  n+=1
  
  # Generate a customized thank-you letter for the attendee using the ERB template
  form_letter = erb_template.result(binding)
  # Save the thank-you letter to a file named after the attendee ID
  save_thank_you_letter(id,form_letter)
end

# Print the most targeted hour and day of the week for attendee registration
puts "Most Targeted Hour is : #{convert_to_time_of_day(count_frequency(hour_of_day))}"
puts "Most Targeted Day is : #{count_frequency(day_of_week)}"