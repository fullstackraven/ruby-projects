require_relative 'node'

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)

    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      @tail.next_node = new_node
      @tail = new_node
    end
  end

  def prepend(value)
    new_node = Node.new(value)

    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      new_node.next_node = @head
      @head = new_node
    end
  end

  def size
    count = 0
    current_node = @head

    while current_node != nil
      count += 1
      current_node = current_node.next_node
    end

    count
  end

  def at(index)
    current_node = @head
    current_index = 0

    while current_node != nil && current_index < index
      current_node = current_node.next_node
      current_index += 1
    end

    current_node
  end

  def pop
    if @head.nil?
      return nil
    elsif @head == @tail
      popped_node = @head
      @head = nil
      @tail = nil
    else
      current_node = @head

      while current_node.next_node != @tail
        current_node = current_node.next_node
      end

      popped_node = @tail
      @tail = current_node
      @tail.next_node = nil
    end

    popped_node
  end

  def contains?(value)
    current_node = @head

    while current_node != nil
      return true if current_node.value == value

      current_node = current_node.next_node
    end

    false
  end

  def find(value)
    current_node = @head
    current_index = 0

    while current_node != nil
      return current_index if current_node.value == value

      current_node = current_node.next_node
      current_index += 1
    end
    nil
  end

  def to_s
    current_node = @head
    string = ""

    while current_node != nil
      string += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    string += "nil"
  end

  def insert_at(value, index)
    new_node = Node.new(value)

    if index == 0
      new_node.next_node = @head
      @head = new_node
    else
      current_node = @head
      current_index = 0

      while current_node != nil && current_index < index - 1
        current_node = current_node.next_node
        current_index += 1
      end

      if current_node.nil?
        return nil
      else
        new_node.next_node = current_node.next_node
        current_node.next_node = new_node
      end
    end
  end

  def remove_at(index)
    if index == 0
      removed_node = @head
      @head = @head.next_node
      removed_node.next_node = nil
    else
      current_node = @head
      current_index = 0

      while current_node != nil && current_index < index - 1
        current_node = current_node.next_node
        current_index += 1
      end

      if current_node.nil? || current_node.next_node.nil?
        return nil
      else
        removed_node = current_node.next_node
        current_node.next_node = current_node.next_node.next_node
        removed_node.next_node = nil

        if current_node.next_node.nil?
          @tail = current_node
        end
      end
    end

    removed_node
  end
end
