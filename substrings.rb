#T.O.P. project
#Implement a method #substrings that takes a word as the first argument and 
#then an array of valid substrings (your dictionary) as the second argument. 
#It should return a hash listing each substring (case insensitive) 
#that was found in the original string and how many times it was found.

#Handles array variable
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(word, array)
    output = Hash.new(0)
    #Handles hash creation
    array.each do |string| 
      parallel = word.downcase.scan(string).length #Handles key/value output and case insensitivity
      output[string] = parallel unless parallel == 0 #Handles logic for output
    end
    return output
end

puts substrings("Howdy partner, sit down! How's it going?",dictionary)