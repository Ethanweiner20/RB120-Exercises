# Method Lookup (Part 2)

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
# cat1.color

p Cat.ancestors

=begin

[Cat, Animal, Object, Kernel, BasicObject] (not found)

=end