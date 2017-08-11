require 'Oystercard'

describe OysterCard do
  let(:station) { double :station }

  it 'shows the initial balance of the card at 0' do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'should top up the card by a value' do
    number = 2.to_f
    expect(subject.top_up(number)).to eq "your oyster card has been topped up by £#{number.to_f}"
  end

  # it "will raise an error if topup will take the balance above 90" do
  #   allow(subject).to receive(:balance).and_return(90)
  # 	expect{(subject.top_up(1))}.to raise_error "Maximum balance exceeded"
  # end

  it 'will raise an error if topup will take the balance above 90' do
    maximum_balance = OysterCard::MAX_BALANCE
    subject.top_up(maximum_balance)
    expect { subject.top_up(0.1) }.to raise_error 'Maximum balance exceeded'
  end

  it 'will deduct an amount of money from the balance' do
    subject.top_up(10)
    subject.tap_in("Morden")
    expect(subject.send(:deduct)).to eq 4
  end

  it { is_expected.to respond_to(:tap_in) }
  it { is_expected.to respond_to(:tap_out) }
  it { is_expected.to respond_to(:in_use?) }

  it 'will touch the customer in' do
    top_up = OysterCard::DEFAULT_TOP_UP_AMOUNT
    subject.top_up(top_up)
    expect(subject.tap_in(station)).to eq 'You have tapped in at #[Double :station]'
  end

  it 'will touch the customer out' do
    subject.top_up(10)
    subject.tap_in(station)
    expect(subject.tap_out(station)).to eq 'you have tapped out at #[Double :station]'
  end

  it 'expects to tell me whether the card is in use?' do
    top_up = OysterCard::DEFAULT_TOP_UP_AMOUNT
    subject.top_up(top_up)
    subject.tap_in('victoria')
    expect(subject.in_use?).to eq true
  end

  it 'Raises an error if there is not enough money' do
    expect { subject.tap_in(station) }.to raise_error "Sorry, you don't have enough money! please top-up!"
  end

  it 'removes an amount from the balance' do
    subject.top_up(20)
    subject.tap_in(station)
    expect { subject.tap_out(station) }.to change { subject.balance }.by(- 2)
  end

  it 'records that a passanger has entered a station' do
    subject.top_up(10)
    subject.tap_in('victoria')
    expect(subject.entry_station).to eq 'victoria'
  end

  it 'has an array of journeys called @journey_array' do
    expect(subject.journey_array.is_a?(Array)).to eq true
  end

  it 'can store new elements as hashes in @journey_array' do
    subject.top_up(10)
    subject.tap_in('Victoria')
    expect(subject.journey_array[0].entry_station).to eq 'Victoria'
  end

  it 'adds the values of station in and out to the entry_station array' do
    subject.top_up(10)
    subject.tap_in('victoria')
    subject.tap_out('St James park')
    expect(subject.journey_array[0].entry_station == 'victoria' && subject.journey_array[0].exit_station == 'St James park').to eq true
  end
end
