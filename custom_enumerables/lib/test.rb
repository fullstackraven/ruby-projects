require_relative 'main'

arr = [1, 2, 3, 4, 5]

# my_each
puts 'Test #my_each vs #each:'
arr.my_each { |n| puts n }
puts "\n"
arr.each { |n| puts n }
# => 1
# => 2
# => 3
# => 4
# => 5
puts "\n"

# my_each_with_index
puts 'Test #my_each_with_index vs #each_with_index:'
arr.my_each_with_index { |n, i| puts "#{i}: #{n}" }
puts "\n"
arr.each_with_index { |n, i| puts "#{i}: #{n}" }
# => 0: 1
# => 1: 2
# => 2: 3
# => 3: 4
# => 4: 5
puts "\n"

# my_select
puts 'Test #my_select vs #select:'
puts arr.my_select { |n| n.even? }
puts "\n"
puts arr.select { |n| n.even? }
# => [2, 4]
puts "\n"

# my_all?
puts 'Test #my_all? vs #all?:'
puts arr.my_all? { |n| n < 10 }
puts "\n"
puts arr.all? { |n| n < 10 }
# => true
puts "\n"

# my_any?
puts 'Test #my_any? vs #any?:'
puts arr.my_any? { |n| n > 5 }
puts "\n"
puts arr.any? { |n| n > 5 }
# => false
puts "\n"

# my_none?
puts 'Test #my_none? vs #none?:'
puts arr.my_none? { |n| n > 5 }
puts "\n"
puts arr.none? { |n| n > 5 }
# => true
puts "\n"

# my_count
puts 'Test #my_count vs #count:'
puts arr.my_count { |n| n.even? }
puts "\n"
puts arr.count { |n| n.even? }
# => 2
puts "\n"
puts arr.my_count(3)
puts "\n"
puts arr.count(3)
# => 1
puts "\n"

# my_map
puts 'Test #my_map vs #map:'
puts arr.my_map { |n| n * 2 }
puts "\n"
puts arr.map { |n| n * 2 }
# => [2, 4, 6, 8, 10]
puts "\n"

# my_inject
puts 'Test #my_inject vs #inject:'
puts arr.my_inject { |sum, n| sum + n }
puts "\n"
puts arr.inject { |sum, n| sum + n }
# => 15