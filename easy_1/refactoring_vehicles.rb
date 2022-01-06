# Refactoring Vehicles

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels
    raise "Exception!"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle
  def wheels
    2
  end
end

class Truck
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

car = Car.new("a", "b")
p car.wheels

=begin

Further Exploration (abstract methods):

It makes sense, under the assumption that all vehicles have wheels. Even for
vehicles, with no wheels, it could be set to zero. A `wheels`
method in the vehicle class is helpful for the following reasons:
- Upon creation of new Vehicle subclasses, the developer might forget to
implement `wheels`. The superclass `wheels` method can be used by default.

The method body could be a couple of things:
- An arbitrary number of wheels (0) for vehicles with no wheels
  - Only vehicles with wheels are implemented
- An error raised (expected to be implemented for the subclass)

=end
