require 'oystercard'

describe Oystercard do
  # subject { Oystercard.new(5) }
  # adds an initialized amout for all those below

  describe '#balance' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:balance)
    end

    it 'should show a balance' do
      expect(subject.balance).to be > 0
    end
  end

  describe '#top_up' do
    it 'should resond to top up' do
      expect(subject).to respond_to(:top_up)
    end

    it 'should increase the balance by an amount' do
      opening_balance = subject.balance
      expect(subject.top_up(5)).to eq(opening_balance + 5)
    end

    it 'should raise an error' do
      error = "Balance cannot exceed #{MAX_BALANCE}"
      expect { subject.top_up(91) }.to raise_error(error)
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to :deduct }

    it 'should deduct the fare amount from the balance' do
      opening_balance = subject.balance
      expect(subject.deduct(5)).to eq(opening_balance - 5)
    end

  end

  describe '#in_journey?' do
    it { is_expected.to respond_to :in_journey? }
  end

  it 'is not in use when initializing' do
    expect(subject).to_not be_in_journey
  # is the same as
  # expect(subject.in_journey?).to eq false

  # predicate matcher be_ implies there is a ? at the end of the method
  # to .to_not (to return false) opposite to .to
  end

  it 'is in journey once they touch in' do
    subject.touch_in
    expect(subject).to be_in_journey
  # is the same as
  # expect(subject.in_journey?).to eq true
  end

  it 'is not in a journey once they touch out' do
    subject.touch_in
    subject.touch_out
    expect(subject).to_not be_in_journey
  end

  it { is_expected.to respond_to :touch_out }

end
