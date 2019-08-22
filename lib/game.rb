# frozen_string_literal: false

require_relative './player.rb'

class Game
  def initialize(turn = 0, use_ai = false)
    @player_turn = turn
    @players = [Player.new('X'), Player.new('O')]
  end

  def valid_move?(cell)
    @players.all? { |player| player.valid_move?(cell) }
  end

  @@positions = [1, 2, 3, 4, 5, 6, 7, 8, 9] # rubocop:disable Style/ClassVars

  def valid_moves
    @@positions.select { |cell| valid_move?(cell) }
  end

  def play(cell)
    return false unless valid_move?(cell)

    @players[@player_turn].play(cell)
    @player_turn = 1 - @player_turn
  end

  def state
    @players.inject('123456789') { |state, player| player.reflect_state(state) }
  end

  def winner
    @players.find(&:winner?)
  end

  def tie?
    state !~ /[0-9]/
  end

  def to_s
    s = state
    " #{s[0]} | #{s[1]} | #{s[2]}\n---+---+---\n" \
    " #{s[3]} | #{s[4]} | #{s[5]}\n---+---+---\n" \
    " #{s[6]} | #{s[7]} | #{s[8]}\n"
  end
end
