require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:balance)
    end

    it 'should show a balance' do
      expect(subject.balance).to be > 0
    end
  end
end
