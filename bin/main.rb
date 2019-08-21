 require './lib/logic.rb'

 puts "START..."

game = Game.new(0)

puts game

until game.winner do
    print "\nMove: "
    move = gets.chomp.to_i
    game.play(move - 1)
    puts "#{game}\n"
end

puts "#{game.winner} wins!"

=begin
puts game.play(7)
puts game
puts "#{game.winner} wins!" if game.winner

puts game.play(6)
puts game
puts "#{game.winner} wins!" if game.winner

puts game.play(8)
puts game
puts "#{game.winner} wins!" if game.winner

puts game.play(0)
puts game
puts "#{game.winner} wins!" if game.winner

puts game.play(1)
puts game
puts "#{game.winner} wins!" if game.winner

puts game.play(3)
puts game
puts "#{game.winner} wins!" if game.winner
=end
