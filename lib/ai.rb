# frozen_string_literal: false

require_relative './player.rb'

class AI < Player
  def fetch_play(current_game)
    current_game.store_state
    move = current_game.valid_moves.sample
    # puts "Valid moves: #{current_game.valid_moves}, chose: #{move}"

    # puts "Random game: #{play_random_game(current_game)}"
    # puts current_game

    move = calc_montecarlo(current_game)

    current_game.restore_state
    move + 1
  end

  def play_random_game(game)
    game.restore_state
    first_move = game.valid_moves.sample
    game.play(first_move - 1)
    until game.winner || game.tie?
      move = game.valid_moves.sample
      game.play(move - 1)
    end
    value = case game.winner
            when self
              10
            when nil
               0
            else
             -15
            end
    [first_move, value]
  end

  def calc_montecarlo(game)
    values = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    counts = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    eta = Time.now + 1.5
    while Time.now < eta

      random = play_random_game(game)
      move, value = random

      # puts "random: #{random} => move: #{move}, value: #{value}"

      values[move - 1] += value
      counts[move - 1] += 1

    end

    bestMove  = 0
    bestScore = -1000000000.0

    for i in 0..8
      score = 1.0 * values[i] / counts[i]
      puts "Score for #{i} is #{score}"
      if score > bestScore
        bestScore = score
        bestMove = i
      end
    end

    puts "Best move is: #{bestMove}"
    bestMove

  end
end