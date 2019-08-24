# frozen_string_literal: false

require_relative './player.rb'

class AIPlayer < Player
  def fetch_play(current_game)
    current_game.store_state
    move = current_game.valid_moves.length == 1 ? current_game.valid_moves.first : calc_montecarlo(current_game)
    current_game.restore_state
    move
  end

  def play_random_game(game, first_move)
    game.play(first_move - 1)
    weight = 9
    until game.winner || game.tie?
      game.play(game.valid_moves.sample - 1)
      weight -= 1
    end

    # This is the heart of the AI: The heuristic
    case game.winner
    when self
      weight
    when nil
      0
    else
      -2 * weight
    end
  end

  def calc_montecarlo(game)
    print "\nThinking..."
    values = Array.new(10, 0)
    counts = Array.new(10, 0)

    total = 0
    eta = Time.now + 0.1
    while Time.now < eta

      game.restore_state
      move = if total < 90
               game.valid_moves.sample
             else
               mul = 2.0 * Math.log(total)
               # puts "\n\nTotal: #{total}, mul: #{mul}\n" if (total % 500).zero?
               game.valid_moves.max_by do |mov|
                 values[mov].to_f / counts[mov] + Math.sqrt(mul / counts[mov])
                 # puts "Factors for #{mov}: #{a} + #{b} = #{score}" if (total % 500).zero?
               end
               # puts "#{best}" if (total % 500).zero?
             end

      values[move] += play_random_game(game, move)
      counts[move] += 1
      total += 1
      print '.' if (total % 500).zero?
    end

    # puts "Number of simulations: #{total}"

    game.restore_state
    game.valid_moves.max_by do |mov|
      # puts "Heuristic for #{mov}: #{values[mov]}/#{counts[mov]} = #{score}"
      values[mov].to_f / counts[mov]
    end
  end
end
