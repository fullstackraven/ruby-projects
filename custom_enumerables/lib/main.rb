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
