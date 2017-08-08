require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  # doube is used as no station class is created but needs to be used
  # created at the beginning of the block so works throughout
  # 1) doesn't depend on the class being created
  #  2) the class won't affect the functionality of the test

  describe '#balance' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:balance)
    end

    it 'should show a balance' do
      subject.top_up 10
      expect(subject.balance).to be > 0
    end

    it 'has a default balance of 0' do
      expect(subject.balance).to be_zero
    end
  end

  describe '#top_up' do
    it 'should respond to top up' do
      expect(subject).to respond_to(:top_up)
    end

    it 'should increase the balance by an amount' do
      opening_balance = subject.balance
      #  .balance being from an attribute reader
      expect(subject.top_up(5)).to eq(opening_balance + 5)
    end

    it 'should raise an error if topping up over limit' do
      error = "Balance cannot exceed #{MAX_BALANCE}"
      expect { subject.top_up(91) }.to raise_error(error)
      #  MAX_BALANCE is a constant from require 'oystercard'
    end
  end

  describe '#deduct' do
    it { is_expected.to_not respond_to :deduct }
  end

  describe '#in_journey?' do
    before { subject.instance_variable_set(:@balance, 30) }
    it { is_expected.to respond_to :in_journey? }
    # stubs:
    #  before setting the balance amount as is needed for in_journey

    it 'is not in use when initializing' do
      expect(subject).to_not be_in_journey
      # is the same as
      # expect(subject.in_journey?).to eq false
      # predicate matcher be_ implies there is a ? at the end of the method
      # .to_not (to return false) opposite to .to
    end

    it 'is in journey once they touch in' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
      # is the same as
      # expect(subject.in_journey?).to eq true
      # station is a double, having 2 benefits:
      #  1) is it not yet created
      #  2) this test will not be dependant on the object/class
    end

    it 'is not in a journey once they touch out' do
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
    #  had to touch in first to touch out

    it { is_expected.to respond_to :touch_out }
  end

  describe '#touch_in' do
    it 'should raise error if insufficient funds' do
      expect { subject.touch_in }.to raise_error 'Insufficient funds'
    end
    # raise erros have to be in a block

    it 'stores station of entry' do
      subject.top_up 10
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    before { subject.instance_variable_set(:@balance, 30) }
    before { subject.touch_in(station) }
    # setting criteria in the block for the rest of the methods
    it 'should reduce the balance by the minimum fair' do
      expect { subject.touch_out }.to change { subject.balance }.by(-1)
    end
    #  as 1 is the minimum amount to get deducted

    it 'forgets entry station on touch out' do
      subject.touch_out
      expect(subject.entry_station).to be_nil
    end

  end
end
