class Person
  def name=(name)
    split_name(name)
  end

  def name
    join_name
  end

  private

  attr_accessor :first_name, :last_name

  def split_name(name)
    full_name = name.split
    self.first_name = full_name.first
    self.last_name = full_name.last
  end

  def join_name
    "#{first_name} #{last_name}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name