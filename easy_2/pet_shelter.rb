# pet_shelter.rb

class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Owner
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def adopt(pet)
    pets << pet
  end

  def number_of_pets
    pets.size
  end

  private

  attr_accessor :pets
end

class Shelter
  attr_reader :name

  def initialize(name = 'The Animal Shelter')
    @name = name
    @adoptions = Hash.new([])
    @pets = []
  end

  def adopt(owner, pet)
    pets.delete(pet)
    adoptions[owner] += [pet]
    owner.adopt(pet)
  end

  def take_in(pet)
    pets << pet
  end

  def print_adoptions
    adoptions.each do |owner, owner_pets|
      puts "#{owner.name} has adopted the following pets:"

      owner_pets.each { |pet| puts pet }
      puts
    end
  end

  def print_pets
    puts "#{name} has the following unadopted pets:"
    pets.each { |pet| puts pet }
    puts
  end

  def number_of_pets
    pets.size
  end

  private

  attr_reader   :adoptions, :pets
end


butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

all_pets = [
  butterscotch, pudding, darwin, kennedy, sweetie,
  molly, chester, asta, laddie, fluffy, kat, ben,
  chatterbox, bluebell
]

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new

all_pets.each do |pet|
  shelter.take_in(pet)
end

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_pets
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "#{shelter.name} has #{shelter.number_of_pets} unadopted pets."