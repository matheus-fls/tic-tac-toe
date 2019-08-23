# frozen_string_literal: false

require_relative './player.rb'
require_relative './ai.rb'

class Game
  def initialize(turn = 0, use_ai = false)
    @player_turn = turn
    @players = [Player.new('X'), use_ai ? AI.new('O') : Player.new('O')]
    @turn_save = nil
  end

  def valid_move?(cell)
    @players.all? { |player| player.valid_move?(cell) }
  end

  @@positions = [1, 2, 3, 4, 5, 6, 7, 8, 9] # rubocop:disable Style/ClassVars

  def valid_moves
    @@positions.select { |cell| valid_move?(cell - 1) }
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
    state !~ /[0-9]/ && !winner
  end

  def fetch_current_player_move
    @players[@player_turn].fetch_play(self)
  end

  def store_state
    @turn_save = @player_turn
    @players.each(&:store_state)
  end

  def restore_state
    @player_turn = @turn_save
    @players.each(&:restore_state)
  end

  def to_s
    s = state
    " #{s[0]} | #{s[1]} | #{s[2]}\n---+---+---\n" \
    " #{s[3]} | #{s[4]} | #{s[5]}\n---+---+---\n" \
    " #{s[6]} | #{s[7]} | #{s[8]}\n"
  end
end
