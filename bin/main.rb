require './lib/logic.rb'

puts "START..."

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
