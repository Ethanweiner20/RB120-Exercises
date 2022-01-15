# Animal Kingdom

class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower)
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

=begin

The problem lies in the `initialize` method defined on line 38-40.

When a `SongBird` object is instantiated, its `initialize` method
is called with 3 arguments passed. The `super` keyword invokes
the `initialize` method in the immediate superclass, passing the 3 arguments along.
The `initialize` method in the immediate superclass is inherited from the
`Animal` class, which accepts only 2 arguments. Hence the ArgumentError.

Further Exploration:

The `FlightlessBird#initialize` method is unnecessary. It invokes `super`,
passing the 2 arguments that were passed into it. If `FlightlessBird#initialize`
were removed, the superclass `initialize` method would also be invoked upon
instantiation. The two options have the exact same effect.

=end
