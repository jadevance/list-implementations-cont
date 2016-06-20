# Quick Example of a Self Referential Data Structure in Ruby
# NODE -> contains a value and a pointer to (next_node)
# LinkedList -> This class holds the linked list functions - adding a node, traversing and displaying the linked list

class Node
 attr_accessor :value, :next_node

 def initialize(val,next_in_line=nil)
   @value = val
   @next_node = next_in_line
   #puts "Initialized a Node with value:  " + value.to_s
 end
end

class LinkedList
 def initialize
   @head = nil
   @size = 0
 end

 def add(value)
   if @size == 0
     @head = Node.new(value,nil)
     @size += 1
   end
   # Traverse to the end of the list
   # And insert a new node over there with the specified value
   current = @head
   while current.next_node != nil
      current = current.next_node
   end
   current.next_node = Node.new(value,nil)
   @size += 1
   self
 end

 def delete(val)
   return nil if @size == 0
   if @head.value == val
     # If the head is the element to be delete, the head needs to be updated
     @head = @head.next_node
     @size -= 1
   else
     # ... x -> y -> z
     # Suppose y is the value to be deleted, you need to reshape the above list to :
     #   ... x->z
     previous = @head
     current = @head.next_node
     while current != nil && current.value != val
       previous = current
       current = current.next_node
     end

     if current != nil
       previous.next_node = current.next_node
       @size -= 1
     end
   end
 end

 def display
   # Traverse through the list till you hit the "nil" at the end
   current = @head
   full_list = []
   while current.next_node != nil
     full_list += [current.value.to_s]
     current = current.next_node
   end
   full_list += [current.value.to_s]
   puts "===" + full_list.join("->") + "==="
 end

 def include?(key)
   current = @head # DON'T LOSE THE HEAD 
   while current != nil
     return true if current.value == key
     current = current.next_node
   end
   return false
 end

 def size
   return @size
 end

 def max
   return nil if @size == 0
   max = @head.value
   current = @head.next_node
   while current != nil
     if current.value > max
       max = current.value
     end
     current = current.next_node
   end
   return max
 end

 def sort
     # loop through all the elements in the linked list
     @size.times do |i|
       ###display
       # each loop through start some temp variables at the front of the list
       before_max = nil
       current = @head
       max = @head
       # each cycle (i-1) elements are already in order at the end of the list
       # so loop through only the elements prior to the ones already in order
       (@size-i-1).times do
         # if you find an element larger than what you think is currently the max
         if current.next_node != nil && current.next_node.value > max.value
           # track the current node as now the max
           # and remember the node in front of the max
           before_max = current
           max = current.next_node
         end
         current = current.next_node
       end
       # once you've looped through all the elements on that cycle,
       # you have found the current largest element in the list
​
       # if it's not the element you're currently on, do some link swapping
       if max != current
         ###puts "max = #{max.value} before_max = #{before_max.nil? ? "nil" : before_max.value} \nmoving max after = #{current.value}"
         if before_max == nil
           # if the max is at the front of the list: special case of moving @head
           @head = @head.next_node
         else
           # otherwise link node before max to node after max
           before_max.next_node = max.next_node
         end
         # insert the max node at the end of the unordered items,
         # but before the ones you've already moved to the end of the list
         max.next_node = current.next_node
         current.next_node = max
       end
     end
   end

   def reverse
     previous_node = nil
     node = @head

     until node.nil?
       next_node = node.next_node
       node.next_node = previous_node
       previous_node = node
       node = next_node
     end
     @head = previous_node
   end  
end


# try sticking the largest one on the end
# Maybe use size
# size - 1 each times loop 
