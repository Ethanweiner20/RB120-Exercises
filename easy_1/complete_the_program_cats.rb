# Complete the Program
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{name} is #{age} years old and has #{color} fur."
  end

  private

  attr_reader :name, :age, :color
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

=begin

we could omit the `initialize` method because `Cat` inherits the attributes
of the `Pet` class, which would now be `name`, `age`, and `color` -- enough
to allow the `Cat#to_s` method to work.

However, this is probably a bad idea. Not every `Pet` might have a `color`, and
we want to keep the `Pet` class as generic as possible, to allow any possible
pets to inherit from it. All pets have a name and age, but it might far-reaching
to assume that we want every pet instance to have a color.

If we did modify `Pet`, I can think of a few options:
- Use an optional parameter in `initialize` for the `color` attribute
- Create a default color, so that other instances of `Pet` just use a default
color

=end