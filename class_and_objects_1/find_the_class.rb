# Find the Class

puts "Hello".class
puts 5.class
puts [1, 2, 3].class

# This works because #class is an Object instance method, and every caller is an
# object.