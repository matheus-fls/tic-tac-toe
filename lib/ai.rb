# frozen_string_literal: false

require_relative './player.rb'

class AIPlayer < Player
  def fetch_play(current_game)
    if current_game.valid_moves.length == 1
      current_game.valid_moves.first
    else
      calc_montecarlo(current_game)
    end
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
    game.store_state

    print "\nThinking..."
    values = Array.new(10, 0)
    counts = Array.new(10, 0)

    total = 0
    eta = Time.now + 0.5
    while Time.now < eta

      game.restore_state
      move = if total < 90
               game.valid_moves.sample
             else
               mul = 2.0 * Math.log(total)
               game.valid_moves.max_by { |mov| values[mov].to_f / counts[mov] + Math.sqrt(mul / counts[mov]) }
             end

      values[move] += play_random_game(game, move)
      counts[move] += 1
      total += 1
      print '.' if (total % 500).zero?
    end

    game.restore_state
    mul = 2.0 * Math.log(total)
    game.valid_moves.max_by { |mov| values[mov].to_f / counts[mov] - Math.sqrt(mul / counts[mov]) }
  end
end
