require 'oystercard'

puts "1) Creating a new card: #{card = Oystercard.new}"
puts "2) Checking the balance: #{card.balance}"
puts "3) Can top_up: #{card.top_up(10)}"
