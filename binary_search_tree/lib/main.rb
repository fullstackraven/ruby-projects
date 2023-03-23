require_relative 'node'
require_relative 'tree'

puts '1. Create a binary search tree from an array of random numbers'
random_array = Array.new(15) { rand(1..100) }
puts "Random Array: #{random_array}"
tree = Tree.new(random_array)
tree.pretty_print
puts ''
puts '2. Confirm that the tree is balanced by calling `#balanced?`'
puts tree.balanced?
puts ''
puts '3. Print out all elements in level, pre, post, and in order'
puts 'Level Order:'
p tree.level_order
puts ''
puts 'Pre Order:'
p tree.preorder
puts ''
puts 'Post Order:'
p tree.postorder
puts ''
puts 'In Order:'
p tree.inorder
puts ''
puts '4. Try to unbalance the tree by adding several numbers > 100'
tree.insert(101)
tree.insert(124)
tree.insert(198)
tree.insert(114)
tree.insert(132)
tree.insert(102)
tree.insert(125)
tree.insert(199)
tree.insert(118)
tree.insert(133)
tree.pretty_print
puts ''
puts '5. Confirm that the tree is unbalanced by calling `#balanced?`'
puts tree.balanced?
puts ''
puts '6. Balance the tree by calling `#rebalance!`'
tree.rebalance!
tree.pretty_print
puts ''
puts '7. Confirm that the tree is balanced by calling `#balanced?`'
puts tree.balanced?
puts ''
puts '8. Print out all elements in level, pre, post, and in order'
puts 'Level Order:'
p tree.level_order
puts ''
puts 'Pre Order:'
p tree.preorder
puts ''
puts 'Post Order:'
p tree.postorder
puts ''
puts 'In Order:'
p tree.inorder
puts ''
puts '9. Try to unbalance the tree by removing several numbers'
tree.delete(101)
tree.delete(124)
tree.delete(198)
tree.delete(114)
tree.delete(132)
tree.delete(102)
tree.delete(125)
tree.delete(199)
tree.delete(118)
tree.delete(133)
tree.pretty_print
puts ''
puts '10. Confirm that the tree is unbalanced by calling `#balanced?`'
puts tree.balanced?
puts ''
puts '11. Balance the tree by calling `#rebalance!`'
tree.rebalance!
tree.pretty_print
puts ''
puts '12. Confirm that the tree is balanced by calling `#balanced?`'
puts tree.balanced?
puts ''
puts '13. Print out all elements in level, pre, post, and in order'
puts 'Level Order:'
p tree.level_order
puts ''
puts 'Pre Order:'
p tree.preorder
puts ''
puts 'Post Order:'
p tree.postorder
puts ''
puts 'In Order:'
p tree.inorder
puts ''
