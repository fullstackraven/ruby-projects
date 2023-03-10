$steps = 0

def merge_sort(array)
  $steps += 1
  return array if array.length <= 1  # returns already sorted

  mid = array.length / 2
  left = merge_sort(array[0...mid]) # recursively calls method for left half
  right = merge_sort(array[mid...array.length]) # recursively calls method for right half

  result = []
  l = r = 0 # index variables

  # Will continue until either l or r reaches the end of their respective arrays
  while l < left.length && r < right.length
    if left[l] < right[r]
      result << left[l]
      l += 1
    else
      result << right[r]
      r += 1
    end
  end

  # Returned result and concatenates the remaining elements in left and right to the result array
  result.concat(left[l..-1]).concat(right[r..-1])
end

# Sets random length and element values for array variable
def randomize_array
  rand_arr = []
  rand(5..20).times do
    num = rand(0..100)
    rand_arr << num
  end
  puts "Unsorted Array: #{rand_arr}"
  rand_arr
end

array = randomize_array
sorted_array = merge_sort(array)

puts "\n"
puts "Sorted Array: #{sorted_array}"
puts "\n"
puts "Steps taken to sort: #{$steps}"
puts "\n"
puts "Recursion is DOPE!"
