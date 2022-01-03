# Generic Greeting (Part 1)

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

# Way 2 (non-preferred)

# def Cat.generic_greeting
#   puts "Hello! I'm a cat!"
# end

kitty = Cat.new
kitty.class.generic_greeting

=begin

This still works, because `class` returns the class of the calling object, which
in this case is `Cat`. `::generic_greeting` is a class method of `Cat`, so the
method is properly invoked.

=end