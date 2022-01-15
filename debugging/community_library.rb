# Community Library

=begin

In this example, the `display_data` method is an instance method of the `Book
class. However, line 42 attempts to invoke `display_data` on an Array of Books
returned by the `books` getter method. This is why long method chains are
advised against.

There are a few options to fix this:
1. Define an instance method on the `Library` class that displays
the books in the library
2. Iterate through the `books`, and call the `display_data` instance
method on each

Option 1 is preferred, because it avoids accessing individual books
outside of the `Library` class.

=end

class Library
  attr_accessor :address, :phone, :books

  def initialize(address, phone)
    @address = address
    @phone = phone
    @books = []
  end

  def check_in(book)
    books.push(book)
  end

  def display_books
    books.each(&:display_data)
  end
end

class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def display_data
    puts "---------------"
    puts "Title: #{title}"
    puts "Author: #{author}"
    puts "ISBN: #{isbn}"
    puts "---------------"
  end
end

community_library = Library.new('123 Main St.', '555-232-5652')
learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

community_library.check_in(learn_to_program)
community_library.check_in(little_women)
community_library.check_in(wrinkle_in_time)

community_library.display_books