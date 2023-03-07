module Enumerable
  def my_each
    return self.to_enum unless block_given?

    self.each { |item| yield(item) }
    self
  end

  def my_each_with_index
    return self.to_enum(:my_each_with_index) unless block_given?

    index = 0
    self.my_each { |item| yield(item, index); index += 1 }
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    results = []
    self.my_each { |item| results.push(item) if yield item }
    results
  end

  def my_all?
    if block_given?
      self.my_each { |item| return false unless yield(item) }
    else
      self.my_each { |item| return false unless item }
    end
    true
  end

  def my_any?
    if block_given?
      self.my_each { |item| return true if yield(item) }
    else
      self.my_each { |item| return true if item }
    end
    false
  end

  def my_none?
    my_each { |item| return false if yield(item) }
    true
  end

  def my_count(item = nil)
    count = 0
    if block_given?
      my_each { |el| count += 1 if yield(el) }
    elsif item
      my_each { |el| count += 1 if el == item }
    else
      count = size
    end
    count
  end

  def my_map
    result = []
    my_each { |item| result << yield(item) }
    result
  end

  def my_inject(initial = nil)
    result = initial.nil? ? self.first : initial
    start = initial.nil? ? self[1..-1] : self
    start.my_each do |item|
      result = yield(result, item)
    end
    result
  end
end

# my_each
# If a block is not given, return an enumerator.
# Otherwise, iterate over each element in the enumerable object, passing each element to the block.

# my_each_with_index
# If a block is not given, return an enumerator.
# Otherwise, iterate over each element in the enumerable object, passing both the element and its index to the block.

# my_select
# If a block is not given, return an enumerator.
# Otherwise, iterate over each element in the enumerable object, and for each element that satisfies the block's condition, add that element to a new array.
# Return the new array containing all the elements that satisfy the block's condition.

# my_all?
# If a block is given, iterate over each element in the enumerable object and return false immediately when an element does not satisfy the block's condition.
# If a block is not given, iterate over each element in the enumerable object and return false immediately when an element is false or nil.
# If all elements satisfy the condition or are true, return true.

# my_any?
# If a block is given, iterate over each element in the enumerable object and return true immediately when an element satisfies the block's condition.
# If a block is not given, iterate over each element in the enumerable object and return true immediately when an element is not false or nil.
# If no elements satisfy the condition or are true, return false.

# my_none?
# Iterate over each element in the enumerable object, and return false immediately when an element satisfies the block's condition.
# If no elements satisfy the condition, return true.

# my_count
# If a block is given, iterate over each element in the enumerable object, and increment a count variable whenever the block's condition is satisfied.
# If an argument is given, iterate over each element in the enumerable object, and increment a count variable whenever an element is equal to the argument.
# If neither a block nor an argument is given, return the size of the enumerable object.

# my_map
# Create a new array.
# Iterate over each element in the enumerable object and pass it to the block, and append the result of each block execution to the new array.
# Return the new array.

# my_inject
# If an initial value is not given, set the result to the first element in the enumerable object, and iterate over the rest of the elements.
# If an initial value is given, set the result to the initial value, and iterate over all elements in the enumerable object.
# For each element, pass the current result and the element to the block, and set the result to the block's return value.
# Return the final result.
