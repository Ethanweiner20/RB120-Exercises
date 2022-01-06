class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata

=begin

This is legal, because a class can have a class method and instance method with
the same name. They are accessed in different ways, so it won't cause problems.

Output:
ByeBye
HelloHello

=end