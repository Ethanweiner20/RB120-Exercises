# Nobility

# Problem: We want to include the title

# Bad code design: Must rewrite `full_name` for every class

module Walkable
  def walk
    "#{full_name} #{gait} forward"
  end
end

class Animal
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def full_name
    name
  end
end

class Person < Animal
  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  private

  def full_name
    "#{title} #{name}"
  end

  def gait
    "struts"
  end
end

class Cat < Animal
  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat
  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
p mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
p kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
p flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
p byron.walk # => "Lord Byron struts forward"
p byron.name
p byron.title

=begin

By using inheritance, we could DRY our code and eliminate some duplication.

I think using `to_s` is not the best way to do this.
- In Walkable#walk, it is not clear what `self` is referring to; using an
explicit method would be better

Options:
- Conditionally implement the `walk` method in `Walkable`
- Override the `walk` method in `Walkable``
- Use a `to_s` method
- Use a different method (e.g. `full_name`)

If overriding isn't necessary, it's probably best to avoid.

`to_s` method isn't descriptive enough in the `walk` method (what is `self`?)

A different method (e.g. `full_name`) defined for each class is best.
- This might seem tedious, but with inheritance it can be achieved easily
- Using the inheritance hierarchy LS offers:
  - Include `full_name` in `Animal`
  - Include `full_name` in `Noble`

Why do I think this is better?
For separating code into distinct purposes
- Ideally, let's allow the `Walkable` module to handle all behaviors relating to walking
(the `walk`) method
- If we can avoid needing to define `walk` in any of these classes, great!
- Instead, let's define a `full_name` method that is more closely tied to the `Animal`
object itself

=end