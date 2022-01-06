# What's The Output

=begin

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

=end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

=begin

The code will print an upcased version of the name: 'FLUFFY'. This results from
the fact that we perform direct mutation on the `@name` instance variable in the
`to_s` instance method, which mutates the string referenced not only by `@name`,
but also by `name`.

To avoid this, we should use a non-mutating method.

If we intend for `@name` to be uppercase, we should call `upcase` on line 5 in
the initialization.

=end

# Further Exploration

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin

In this instance, `@name` does not reference the same object that `name`
references, because `to_s` returns a string object `'42'`, not the same integer
`42`. And the `upcase!` mutating method invocation has no effect on either
`@name` or `name`, because `@name` references a string with only digits.

Likewise, the `name` reassignment has no effect on `@name`.

=end