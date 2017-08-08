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

    # it 'should deduct the fare amount from the balance' do
    #   opening_balance = subject.balance
    #   expect { subject.deduct(5) }.to eq(opening_balance - 5)
    # end

  end
end
