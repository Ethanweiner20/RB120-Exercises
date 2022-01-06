# Fix the Program

class Book
  attr_accessor :author, :title

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# I prefer the design of the previous program (requiring author & title upon initialization)

=begin

From a perspective of "what makes sense" in the context of the problem:

In general, a Book doesn't make sense without a `title` and `author`, so those
attributes should be set upon initialization.

Perhaps we do give the `title` and `author` setter methods: titles of books can
change, and so can authors.

From a technical perspective: It depends on so many factors:
- Do you want data to be protected? Then don't allow setters.
- Do you want to save storage, and allow books to be reinitialized? Then allow setters.
- (per @Bob Rhodes answer)
- Do you need to ensure `nil` is never returned upon trying to access the author or title?
Then make sure to set the `title` and `author` during initialization.
- etc. etc.

=end