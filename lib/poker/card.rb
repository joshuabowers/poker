module Poker
  class Card
    class << self
      attr_accessor :suits, :values
    end
    
    self.suits = {hearts: :"\u2661", diamonds: :"\u2662", spades: :"\u2660", clubs: :"\u2663"}
    self.values = Set.new((2..10).to_a + %i{J Q K A})
    
    attr_reader :suit, :value
    
    def suit=(s)
      @suit = self.class.suits[s] || s
    end
    
    def value=(v)
      @value = v if self.class.values.include?(v)
    end
    
    def initialize(*args)
      options = args.extract_options!
      self.suit, self.value = *args if args.size == 2
      options.each do |key, value|      
        send("#{key}=", value)
      end
    end

    def to_s
      "#{value}#{suit}"
    end
  end
end