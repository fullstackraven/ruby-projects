#T.O.P Project
#Build a method #bubble_sort that takes an array 
#and returns a sorted array. It must use the bubble sort methodology.

sort_me = [2, 3, 5, 6, 0, 1, 9, 4, 7, 8]

def bubble_sort(array)
  if array.size <= 1
    return array
  end
  #Will return array if the array is either 0 or 1 elements in length

  output = " "
  counter = 1 #Iteration counter variable
  swapped = true #Check variable

  while swapped do
    swapped = false
    (array.size - 1).times do |i|
      if array[i] > array[i + 1]
      array[i], array[i + 1] = array[i + 1], array[i]
      swapped = true
      #Iterates over array, swapping numbers until each number is smaller than the one to the right
      counter = counter + 1
      #Handles iteration counter incrementation
      end
    end
  end
  puts ("Finished #{counter} iterations to complete sort")
  output = "Sorted array: #{array}"
end

puts bubble_sort(sort_me)
# => Finished 14 iterations to complete sort
# => Sorted array: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]