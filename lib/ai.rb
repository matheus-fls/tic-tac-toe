# frozen_string_literal: false

require_relative './player.rb'

class AI < Player
  def fetch_play(current_game)
    current_game.store_state
    move = if current_game.valid_moves.length == 1
      current_game.valid_moves.first
    else
      calc_montecarlo(current_game) + 1
    end
    current_game.restore_state
    move
  end

  def play_random_game(game)
    game.restore_state
    first_move = game.valid_moves.sample
    game.play(first_move - 1)
    until game.winner || game.tie?
      move = game.valid_moves.sample
      game.play(move - 1)
    end

    [first_move, case game.winner
                 when self
                   1
                 when nil
                   0
                 else
                   -2
                 end
    ]
  end

  def calc_montecarlo(game)
    print "\nThinking..."
    values = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    counts = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    count = 0
    eta = Time.now + 1.5
    while Time.now < eta
      random = play_random_game(game)
      move, value = random
      values[move - 1] += value
      counts[move - 1] += 1
      print '.' if ((count += 1) % 500).zero?
    end

    best = [0, -9e9]
    values.each_with_index do |value, move|
      score = value.to_f / counts[move]
      best = [move, score] if score > best.last
    end

    best.first
  end
end