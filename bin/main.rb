require_relative '../lib/game.rb'
require_relative '../lib/banner.rb'

puts "START..."

alphabet = Alphabet.new

puts alphabet.to_banner "O|X|3"
puts "###################################"
puts alphabet.to_banner "4|5|9"
puts "###################################"
puts alphabet.to_banner "7|8|3"


game = Game.new(0)

puts game

until game.winner || game.tie? do
    print "\nMove: "
    move = gets.chomp.to_i
    unless game.play(move - 1)
      puts "Invalid move! Try again"
    end
    puts "#{game}\n"
end

if game.winner
  puts "#{game.winner} wins!"
else
  puts "It's a tie!"
end
