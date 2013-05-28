module Poker
  class Deck
    attr_reader :cards, :dealt
    
    # Ideally, this would take the number of decks to create as one of the initilization arguments.
    def initialize(*args)
      reset
    end
    
    # Creates a new set of cards, ordered based on suit and face value
    def reset
      @cards = Card.suits.keys.map do |suit|
        Card.values.map {|i| Card.new(suit, i)}
      end.flatten
      @dealt = []
      self
    end
    
    # Randomly orders the deck
    def shuffle
      @cards.shuffle!
      self
    end
    
    def deal
      reset and shuffle if @cards.empty?
      @cards.pop.tap {|c| @dealt << c}
    end
    
    def empty?
      @cards.empty?
    end
    
    def inspect
      "Deck: #{@dealt.count} / #{@cards.count} (dealt / remain)"
    end
  end
end