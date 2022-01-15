# Wish You Were Here

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  def ==(other_location)
    latitude = other_location.latitude && longitude == other_location.longitude
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false

=begin

When line 41 is invoked, `ada.location` returns a `GeoLocation` object, and the
`#==` instance method is invoked on it. Since no `GeoLocation#==` equivalence
method is defined, it uses the `BasicObject#==` through inheritence instead,
which returns true if and only if two objects are the SAME object.

In this instance, we have two separate `GeoLocation` objects, each of which has
the same coordinates. Therefore, `false` will be returned upon comparison. In
order to return `true` for same-value locations, we must define a
`GeoLocation#==` method that compares in this manner.

=end