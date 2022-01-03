class Cat
  @@count = 0

  def initialize
    @@count += 1
  end

  def self.total
    puts @@count
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total