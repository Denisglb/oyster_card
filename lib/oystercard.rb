
class OysterCard
  attr_reader :balance, :entry_station, :journey_array, :fare

  MAX_BALANCE = 90
  DEFAULT_TOP_UP_AMOUNT = 5

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_array = []
    @fare = fare
  end

  def top_up(value)
    raise 'Maximum balance exceeded' if value + @balance > MAX_BALANCE
    @balance += value.to_f
    "your oyster card has been topped up by £#{value.to_f}"
  end

  def tap_in(station)
    raise "Sorry, you don't have enough money! please top-up!" if @balance <= 1
    raise 'error, you have already tapped in' unless @entry_station.nil?
    @entry_station = station
    @journey_array << Journey.new(station)
    "You have tapped in at #{station}"
  end

  def tap_out(station)
    @entry_station = nil
    @journey_array[-1].exit_station = station
    deduct
    "you have tapped out at #{station}"
  end

  def in_use?
    !!@entry_station
  end

  private

  def deduct
    @balance -= @journey_array[-1].fare
  end
end
