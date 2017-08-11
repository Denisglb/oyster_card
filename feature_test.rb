require './lib/journey.rb'
require './lib/oystercard.rb'
card = OysterCard.new
card.top_up(20)
card.tap_in("victoria")
card.tap_out("aldgate East")
card.balance
card.tap_in("victoria")
card.tap_in("Bank")
card.balance
card.tap_out("monumnet")
card.balance
card.tap_out("sjp")
card.balance

# journey = Journey.new("victoria")
# journey.incomplete?
# journey.fare