require 'spec_helper'

describe Poker do
  it "should have a Deck class" do
    subject.const_get(:Deck).should_not be_nil
    subject.const_get(:Deck).should be_a(Class)
  end
end

describe Deck do
  it { should respond_to(:reset) }
  it { should respond_to(:shuffle) }
  it { should respond_to(:deal) }
  it { should respond_to(:cards) }
  it { should respond_to(:dealt) }
  it { should respond_to(:empty?) }
end

shared_examples_for "a reset deck" do
  its(:cards) { should_not be_empty }
  its(:cards) { should have(52).items }
  its(:dealt) { should be_empty }
  it { should_not be_empty }
end

describe "A new Deck" do
  subject { Deck.new }
  it_behaves_like "a reset deck"
end

describe "A reset Deck" do
  subject do
    Deck.new.tap do |d|
      d.deal
      d.reset
    end
  end
  it_behaves_like "a reset deck"
end

describe "A Deck with dealt cards" do
  subject do
    Deck.new.tap do |d|
      5.times { d.deal }
    end
  end
  it { should_not be_empty }
  its(:cards) { should_not be_empty }
  its(:dealt) { should_not be_empty }
end

describe "An empty Deck" do
  subject do
    Deck.new.tap do |d|
      d.deal until d.empty?
    end
  end
  it { should be_empty }
  its(:cards) { should be_empty }
  its(:dealt) { should_not be_empty }
end

describe "Dealing from an empty Deck" do
  before(:each) { @deck = Deck.new.tap {|d| d.deal until d.empty? }}
  it "should reset the #cards before dealing a card" do
    expect { @deck.deal }.to change { @deck.cards.count }.from(0).to(51)
  end
  it "should reset the dealt log before dealing a card" do
    expect { @deck.deal }.to change { @deck.dealt.count }.from(52).to(1)
  end
end

describe Deck, "#deal" do
  let(:deck) { Deck.new }
  subject { deck.deal }
  it { should be_a(Poker::Card) }
end

describe Deck do
  it "should remove a card from the deck when dealt" do
    expect { subject.deal }.to change { subject.cards.count }.by(-1)
  end
  it "should add a card to the dealt log when dealt" do
    expect { subject.deal }.to change { subject.dealt.count }.by(1)
  end
end
