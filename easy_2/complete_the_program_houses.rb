# Complete The Program

# You must modify the `House` class itself, not the way it's accessed
# Idea: Define a Home#< and Home#> method? (would require more)
# Idea: Define the <=> operators?
# to_s equivalent for comparison?

# Note: ALL COMPARISON operators use the Comparable#<=> method (therefore override)

class House
  include Comparable

  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other_house)
    price <=> other_house.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# What's happening:

# Comparable#< and Comparable#> are invoked on the houses. These calls use
# House#<=> to perform the underlying comparison. The Comparable module is
# needed.

=begin

I don't think House objects should be considered comparable, since there are
many possible factors that could be used for comparison:
- Price
- Area
- Volume
- etc.

It's better off to just compare houses by the property necessary: e.g. compare
prices directly.

Classes that would benefit from using the Comparable module are those with
exactly one good method of comparison: in this case, it is clear how the objects
are being compared. Some examples are:
- A Score class (the numerical score)
- A Sound class (loudness)

=end