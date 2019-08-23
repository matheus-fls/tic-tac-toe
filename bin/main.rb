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
    #puts "#{@game}\n"
    # puts alphabet.to_banner "O|X|3"
    # puts "###################################"
    # puts alphabet.to_banner "4|5|9"
    # puts "###################################"
    # puts alphabet.to_banner "7|8|3"

  end

  def play_match
    display_board
    until @game.winner || @game.tie? do
      print "\nMove: "
      move = gets.chomp.to_i
      unless @game.play(move - 1)
        puts "Invalid move! Try again"
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

puts "START...\n "

match = Match.new

match.run
