class Card
  include Comparable
  RANK_VALUES =
  {
    1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5,
    6 => 6, 7 => 7, 8 => 8, 9 => 9, 10 => 10,
    'Jack' => 11, 'Queen' => 12, 'King' => 13,
    'Ace' => 14
  }
  SUIT_VALUES = { 'Diamonds' => 1, 'Clubs' => 2, 'Hearts' => 3, 'Spades' => 4 }

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ==(other)
    rank == other.rank && suit == other.suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  protected

  def <=>(other)
    if rank == other.rank
      return SUIT_VALUES[suit] <=> SUIT_VALUES[other.suit]
    end
    RANK_VALUES[rank] <=> RANK_VALUES[other.rank]
  end
end

cards = [Card.new(2, 'Hearts'),
         Card.new(10, 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8