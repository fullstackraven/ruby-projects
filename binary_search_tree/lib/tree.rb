require_relative 'node'
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = arr.length / 2
    node = Node.new(arr[mid])
    node.left = build_tree(arr[0...mid])
    node.right = build_tree(arr[(mid + 1)..-1])
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    insert_recursive(@root, value)
  end

  def delete(value)
    delete_recursive(@root, value)
  end

  def find(value, current = @root)
    return "These are not the nodes you are looking for" if current.nil?
    return current if current == value

    current > value ? find(value, current.left) : find(value, current.right)
  end

  def level_order(node = @root, &block)
    return [] if node.nil?

    queue = [@root]
    result = []
    while !queue.empty?
      node = queue.shift
      block_given? ? yield(node) : result << node.data
      queue << node.left if node.left
      queue << node.right if node.right
    end
    result
  end

  def inorder(node = @root, &block)
    return [] if node.nil?

    result = []
    result += inorder(node.left, &block)
    block_given? ? yield(node) : result << node.data
    result += inorder(node.right, &block)
    result
  end

  def preorder(node = @root, &block)
    return [] if node.nil?

    result = []
    block_given? ? yield(node) : result << node.data
    result += preorder(node.left, &block)
    result += preorder(node.right, &block)
    result
  end

  def postorder(node = @root, &block)
    return [] if node.nil?

    result = []
    result += postorder(node.left, &block)
    result += postorder(node.right, &block)
    block_given? ? yield(node) : result << node.data
    result
  end

  def height(node = @root)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node, parent = @root)
    return 0 if node == parent

    if node < parent.data
      1 + depth(node, parent.left)
    else
      1 + depth(node, parent.right)
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
      return true
    end

    false
  end

  def rebalance!
    @root = build_tree(inorder)
  end

  private

  def insert_recursive(node, value)
    return Node.new(value) if node.nil?
    return node if node == value

    if value < node.data
      node.left = insert_recursive(node.left, value)
    else
      node.right = insert_recursive(node.right, value)
    end

    node
  end

  def delete_recursive(node, value)
    return node if node.nil?

    if value < node.data
      node.left = delete_recursive(node.left, value)
    elsif value > node.data
      node.right = delete_recursive(node.right, value)
    else
      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end

      temp = find_min_node(node.right)
      node.data = temp.data
      node.right = delete_recursive(node.right, temp.data)
    end

    node
  end

  def find_min_node(node)
    current = node
    current = current.left until current.left.nil?
    current
  end
end
