require_relative '../lib/game.rb'
require_relative './banner.rb'

class Match
  def initialize(one_player = false)
    @game = Game.new(0, one_player)
    @alphabet = Alphabet.new
    @score = {"X" => 0, "O" => 0}
  end

  def display_board
    s = @game.state
    puts @alphabet.to_banner "#{s[0]}|#{s[1]}|#{s[2]}"
    puts "###################################"
    puts @alphabet.to_banner "#{s[3]}|#{s[4]}|#{s[5]}"
    puts "###################################"
    puts @alphabet.to_banner "#{s[6]}|#{s[7]}|#{s[8]}"
  end

  def play_match
    display_board
    until @game.winner || @game.tie? do
      move = @game.fetch_current_player_move
      unless @game.play(move - 1)
        puts "Invalid move! (#{move}) Try again"
      end
      display_board
    end
    
    if @game.winner
      puts "#{@game.winner} wins!"
      @score[@game.winner.token] += 1
    else
      puts "It's a tie!"
    end
  end

  def run
    loop do
      @game = Game.new
      play_match
      puts "Player1 Score: #{@score['X']} | Player2 Score: #{@score['O']}\n "
      print "Play again? Y/N  "
      foo = gets.chomp
      if foo.upcase != "Y"
        break
      end
    end
  end
end

match = Match.new
match.run

=begin 
game = Game.new
game.play(4)
game.fetch_current_player_move

puts game
puts "\n "

=end