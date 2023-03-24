def knight_moves(start, finish)
  # Establish all possible moves for knight
  moves = [[1, 2], [2, 1], [-1, 2], [2, -1], [-2, 1], [1, -2], [-1, -2], [-2, -1]]

  # Create a queue array to store nodes
  queue = [[start]]

  # Create a set to handle visited nodes 
  visited = [start]

  # BFS Traverse of graph/'board'
  while(queue.size != 0)
    travails = queue.shift
    node = travails.last
  
    # Are we there yet?
    if node == finish
      return travails
    end

    # Create child nodes
    child_nodes = moves.map { |move| [node[0] + move[0], node[1] + move[1]] }

    # Filter the child nodes that have been visited or are off the board
    child_nodes = child_nodes.select { |node|
      node[0].between?(0, 7) && node[1].between?(0, 7) && !visited.include?(node)
    }

    # Store child nodes in the queue and set them as visited
    child_nodes.each do |node|
      visited << node
      queue << travails + [node]
    end
  end

  # If the desination is not reachable, return nil
  return nil
end

p knight_moves([0, 0], [1, 2]) # => 1 move

p knight_moves([0, 0], [3, 3]) # => 2 moves

p knight_moves([3, 3], [0, 0]) # => 2 moves

p knight_moves([3, 3], [4, 3]) # => 3 moves

p knight_moves([0, 0], [6, 7]) # => 5 moves

p knight_moves([0, 0], [7, 8]) # => nil 

puts "You made it in #{knight_moves([3, 3], [4, 3]).length - 1} moves! Here's your path:"
knight_moves([3, 3], [4, 3]).each { |square| puts square.inspect }
# You made it in 3 moves! Here's your path:
# [3, 3]
# [4, 5]
# [6, 4]
# [4, 3]
