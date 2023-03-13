require_relative 'lib/linked_list'
require_relative 'lib/node'

list = LinkedList.new
list.append(5)
list.append(10)
list.prepend(1)
list.append(15)
puts list.to_s #=> ( 1 ) -> ( 5 ) -> ( 10 ) -> ( 15 ) -> nil
puts list.size #=> 4
puts list.head.value #=> 1
puts list.tail.value #=> 15
puts list.at(2).value #=> 10
list.pop
puts list.to_s #=> ( 1 ) -> ( 5 ) -> ( 10 ) -> nil
puts list.contains?(5) #=> true
puts list.contains?(20) #=> false
puts list.find(5) #=> 1
puts list.find(20) #=> nil
list.insert_at(9, 1)
puts list.to_s # ( 7 ) -> ( 9 ) -> ( 5 ) -> ( 3 ) -> nil
list.remove_at(2)
puts list.to_s # ( 7 ) -> ( 9 ) -> ( 3 ) -> nil
