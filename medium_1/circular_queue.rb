# Circular Queue

require 'pry'

=begin

Rules:
- Adding: Adds immediately after most recently added object
- Removing: Removes object in queue the longest (first in, first out)
- [Differene from regular queue] A *buffer* exists = circle circumference
  - Once buffer is full, adding new => removing old
- Stores no `nil` objects (`nil` represents an empty spot)

Ideas:
- Use PEDAC? (doesn't really make sense yet -- unclear inputs & outputs)
- Keep track of items in a particular order (use an array for ordering)
- Use an empty queue or array of `nil`s?
- We want to be able to use `shift`/`unshift` methods
- Used FixedArray class from previous exercise?

Option 1:
- Use a variable-size array that is queued and dequeued until it's a max length
  - #push for enqueue, and #unshift for dequeue
  - Orders elements on insertion order => allows for queue rules
  - GUARANTEES that oldest elements are to the start, because newest elements
  are PUSHED TO THE END

=end

# Option 1

=begin

class CircularQueue
  def initialize(buffer_size)
    @max_size = buffer_size
    @buffer = [] # Collaboration with Array
  end

  def enqueue(object)
    if buffer.length == max_size
      dequeue
    end

    buffer.push(object)
  end

  def dequeue
    buffer.shift # Returns nil if buffer is empty
  end

  private

  attr_reader :max_size, :buffer
end

=end

=begin

Option 2:
- Use a fixed-size array (initially of `nil`s)
  - Disadvantage: Doesn't allow for any sort of ordering
  - State:
    - Buffer itself
    - The oldest index (continually moves right)
    - The newest index (most recent added)
=end

class CircularQueue
  def initialize(size)
    @buffer = Array.new(size)
    @oldest_index = 0
    @insertion_index = 0
  end

  def enqueue(object)
    dequeue unless buffer[insertion_index].nil?
    buffer[insertion_index] = object
    self.insertion_index = increment(insertion_index)
  end

  def dequeue
    if buffer.all?(nil)
      nil
    else
      removed_element = buffer[oldest_index]
      buffer[oldest_index] = nil
  
      self.oldest_index = increment(oldest_index)
      removed_element
    end
  end

  def increment(index)
    (index + 1) % buffer.size
  end

  private

  attr_reader :buffer
  attr_accessor :oldest_index, :insertion_index
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
