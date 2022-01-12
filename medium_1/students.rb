# Students

class Person
  def initialize
    @species = "human"
  end
end

class Student < Person
  def initialize(name, year)
    super()
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end

=begin

Further Exploration

Why would we want use `super()` in a student related class?

Suppose we have an instance method defined on the `Student` class that does not
take any arguments, but then we override that instance method in a subclass of
`Student`, that does take arguments. If we want to invoke the method associated
with the superclass without passing any arguments, we must invoke the `super`
keyword like this: `super()`>

=end