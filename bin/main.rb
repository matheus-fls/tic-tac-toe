require_relative '../lib/game.rb'
require_relative './banner.rb'

class Match
  def initialize(one_player = false)
    @game = Game.new(0, one_player)
    @alphabet = Alphabet.new
    @score = {"X" => 0, "O" => 0}
    @turn = 0
  end

  def cls
    system("clear") || system("cls")
  end

  def display_board
    cls
    s = @game.state
    puts @alphabet.to_banner "#{s[0]}|#{s[1]}|#{s[2]}"
    puts "###################################"
    puts @alphabet.to_banner "#{s[3]}|#{s[4]}|#{s[5]}"
    puts "###################################"
    puts @alphabet.to_banner "#{s[6]}|#{s[7]}|#{s[8]}"
  end

  def play_match
    until @game.winner || @game.tie? do
      move = @game.fetch_current_player_move
      unless @game.play(move - 1)
        puts "Invalid move! (#{move}) Try again"
      end
      display_board
    end

    if @game.winner
      puts "\n#{@game.winner} wins!"
      @score[@game.winner.token] += 1
    else
      puts "\nIt's a tie!"
    end
  end

  def run
    cls
    puts '*******************************************************'
    puts '*                  TIC-TAC-TOE                        *'
    puts '*******************************************************'
    puts "        by the Fantastic Duo: Math & Monstruo\n\n"

    oponent = ''
    until oponent == 'H' || oponent == 'C'
      print 'Play against (H)uman or (C)omputer? '
      oponent = gets.chomp.upcase
    end

    loop do
      @game = Game.new(@turn, oponent == 'C')
      display_board if @turn.zero? || oponent == 'H'

      play_match

      if @game.tie?
        @turn = 1 - @turn
      else
        @turn = @game.winner.token == 'X' ? 0 : 1
      end
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
