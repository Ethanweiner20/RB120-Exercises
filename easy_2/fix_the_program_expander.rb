# Fix the Program

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

=begin

The only problem I can see is that the `self` is not needed on line 7, since the
scope of `to_s` is the object instance itself, and `expand` will be invoked on
the object instance without `self`.

Furthermore, in previous versions of Ruby, it was illegal to invoke private
methods with a literal `self` as the caller, so the code would've raised an error.

=end