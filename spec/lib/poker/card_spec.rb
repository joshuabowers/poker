require 'spec_helper'

describe Poker do
  it "should have a Card class" do
    subject.const_get(:Card).should_not be_nil
    subject.const_get(:Card).should be_a(Class)
  end
end

describe Card do
  subject { Card }
  
  it "should have a :suits class attribute" do
    subject.should respond_to(:suits)
  end
  
  its(:suits) { should_not be_empty }
  its(:suits) { should be_a(Hash) }
  
  it "should have a :values class attribute" do
    subject.should respond_to(:values)
  end
    
  its(:values) { should_not be_empty }
  its(:values) { should be_a(Set) }
end