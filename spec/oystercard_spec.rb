require 'oystercard'
require 'station'

describe Oystercard do
  let(:station) { double :station }
  let(:station1) { double :station1 }
  let(:journey) { double :journey }

  context '#init' do
    it 'should start with an empty hash' do
      criteria1 = subject.balance == DEFAULT_BALANCE
      criteria2 = subject.current_journey.nil?
      criteria3 = subject.trip_history.empty?
      expect(criteria1 && criteria2 && criteria3).to eq true
    end
  end

  context '#balance' do
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

  context '#top_up' do
    it 'should respond to top up' do
      expect(subject).to respond_to(:top_up)
    end

    it 'should increase the balance by an amount' do
      opening_balance = subject.balance
      expect(subject.top_up(5)).to eq(opening_balance + 5)
    end

    it 'should raise an error if topping up over limit' do
      error = "Balance cannot exceed #{MAX_BALANCE}"
      expect { subject.top_up(91) }.to raise_error(error)
    end
  end

  context '#deduct' do
    it { is_expected.to_not respond_to :deduct }
  end

  context '#in_journey?' do
    before { subject.instance_variable_set(:@balance, 30) }
    it { is_expected.to respond_to :in_journey? }

    it 'is not in use when initializing' do
      expect(subject).to_not be_in_journey
    end

    it 'is in journey once they touch in' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'is not in a journey once they touch out' do
      subject.touch_in("Victoria")
      subject.touch_out(station1)
      expect(subject).to_not be_in_journey
    end

    it { is_expected.to respond_to :touch_out }
  end

  context '#touch_in' do
    it 'should raise error if insufficient funds' do
      expect { subject.touch_in(station) }.to raise_error 'Insufficient funds'
    end

    it 'will charge a penalty fare if touch in twice without touching out between' do
      subject.top_up(10)
      subject.touch_in('Victoria')
      expect { subject.touch_in "StJamesPark" }.to change { subject.balance }.by(- PENALTY_FARE)
    end

    it 'creates a new journey when tapping in' do
      subject.top_up 10
      subject.touch_in(station)
      expect(subject.current_journey.is_a?(Journey)).to eq true
    end

    it 'tapping in initializes new journey instance' do
      expect(Journey).to receive(:new).with(station)
      subject.top_up 10
      subject.touch_in(station)
    end

  end

  context '#touch_out' do
    before { subject.instance_variable_set(:@balance, 30) }
    before { subject.touch_in(station) }
    # setting criteria in the block for the rest of the methods
    it 'should reduce the balance by the minimum fair' do
      allow(station).to receive(:intern)
      expect { subject.touch_out(station1) }.to change { subject.balance }.by(- MINIMUM_FARE)
    end

    it 'ends the current journey on touch out and transfers to trip_history' do
      allow(station).to receive(:intern)
      expect(station).to receive(:intern)
      expect(subject.current_journey).to receive(:end_journey)
      subject.touch_out(station1)
    end

    it "charges a penalty fare if user didn't tap in" do
      allow(station).to receive(:intern)
      subject.touch_out(station1)
      expect { subject.touch_out(station) }.to change { subject.balance }.by(- PENALTY_FARE)
    end

  end

end
