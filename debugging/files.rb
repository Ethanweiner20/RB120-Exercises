# Files

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

=begin

The problem relates to how constant resolution works in Ruby. The reference to
`FORMAT` on line 21 first checks the lexical scope for a constant named
`FORMAT`, which is dependent on the `File` class. Next, the ancestors
of `File` are searched for `FORMAT`, none of which include the `CONSTANT`. The
subclasses of `File` are simply never searched. This contrast instance
variables, which are resolved at runtime, and thus would evaluated to their
associated values in the subclass.

Possible ways to fix:
- Use the namespacing operator `::` to directly extract the constant from the
desired class; this works because constants are resolved different with `::`
prepended
- Use an instance variable `@format` or instance method `#format` in each
subclass, and access from `to_s` in the superclass; this works because
instance variables are resolved at runtime and instance methods are invoked
at runtime
- Define separate constants in the superclass for each file type (not ideal)
- Define `to_s` in each subclass, and directly call the constants (not ideal,
because code isn't DRY)

=end

=begin

Module #alias_method

Guess: Using the symbols passed in as arguments, defines a new method that is
a copy of the 2nd-symbol method

Usefulness: When you want to override a method, but keep a copy of the original

=end