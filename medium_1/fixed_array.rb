# Fixed Array

=begin

Notes:
- Elements should be initialized to `nil` by default
- Raise index errors when accessing out-of-bounds elements (positive or negative)
  - Use fetch?
- Implement getters & setters w/ syntactic sugar
- Implment a `to_a` and `to_s` instance method
  - `to_s` instance method should use inspect

=end

class FixedArray
  def initialize(length)
    @length = length
    @elements = [nil] * length
  end

  def [](index)
    elements.fetch(index)
  end

  def []=(index, value)
    unless index >= 0 && index < length
      raise IndexError, "Index #{index} is not in the array."
    end

    elements[index] = value
  end

  def to_a
    elements.clone # Copy array so outside users can't mess w/ fixed size
  end

  def to_s
    elements.inspect
  end

  private

  attr_reader :length
  attr_accessor :elements
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'


begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end


begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end