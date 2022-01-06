class Shelter
  def initialize
    @owners = []
    @housed_pets = []
  end

  def adopt(owner, pet)
    owner.adopt(pet)
    @housed_pets.delete(pet)
    @owners << owner unless @owners.include?(owner)
  end

  def house(pet)
    @housed_pets << pet
  end

  def print_unadopted_pets
    puts "The Animal Shelter has the following unadopted pets:"
    puts @housed_pets
    puts
  end

  def print_adoptions
    @owners.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.print_adoptions
      puts
    end
  end

  private

  attr_accessor :owners
end

class Owner
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def adopt(pet)
    @pets << pet
  end

  def number_of_pets
    @pets.length
  end

  def print_adoptions
    puts @pets
  end
end

class Pet
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
  end

  def to_s
    "a #{species} named #{name}"
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
lady         = Pet.new('dog', 'Lady')
bentley      = Pet.new('dog', 'Bentley')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
ethan   = Owner.new('Ethan')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.house(darwin)
shelter.house(kennedy)
shelter.house(sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.adopt(ethan, lady)
shelter.adopt(ethan, bentley)

shelter.print_unadopted_pets
shelter.print_adoptions

[phanson, bholmes, ethan].each do |owner|
  puts "#{owner.name} has #{owner.number_of_pets} adopted pets."
end

=begin

Reverse engineering:
- Shelters can adopt pets to an owners #adopt(owner, pet)
- An owner has an @name and @number_of_pets

Collaboration Diagram:
- Shelter (owners)
  - Owner (name, pets)
    - Pet (species, name)

Challenge: Modify the shelter system to include unadopted pets, without
modifying existing interface.

I think this exercise is a great example of the benefits of OOP: the ability
to update or extend a class's functionality without needing to reproduce its
existing interface. As long as the class is designed with intention, and the
interface is a good one, we can scale a program without wrecking what we already
did.

=end