# Fix the Program

class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin

Further Exploration:

`attr_writer` would not suffice, because it would not provide us with the needed
`title` and `author` getter methods. `attr_accessor` would provide us with such
getters, but would also provide us with setter methods, which might be
undesirable as to properly protect data and avoid unnecessary additions to the
interface.

This would not change the behavior of the class in any way, assuming `title` and
`author` are public. Those are exactly the methods that `attr_reader` creates.
The only advantage I can this of is explicitness: you clearly see that the class
has getters, and that those getters do not return a copy of the instance
variable, but rather the object referenced by the instance variable itself. It 
also suggests that there could be custom implementation for those methods.

=end