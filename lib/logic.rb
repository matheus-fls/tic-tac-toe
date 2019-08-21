# frozen_string_literal: true

class GameState
  def initialize
    @board = [0, 0, 0,
              0, 0, 0,
              0, 0, 0]
  end

  # Will determine if it's a winning state
  def winner?
    false
  end

  def play(cell)
    @board[cell] = 1
  end

  def valid_move?(cell)
    @board[cell].zero?
  end
end

class Player
  def initialize(token) # Either O or X
    @token = token
    @state = GameState.new
  end

  def winner?
    false
  end

  def valid_move?(cell)
    @state.valid_move?(cell)
  end

  def play(cell)
    @state.play(cell)
  end
end

class Game
  def initialize(turn = 0)
    @player_turn = turn
    @players = [Player.new('X'), Player.new('O')]
  end

  def valid_move?(cell)
    @players.all? { |player| player.valid_move?(cell) }
  end

  def valid_moves
    (1...9).to_a.select { |cell| valid_move?(cell) }
  end

  def play(cell)
    @players[@player_turn].play(cell)
    @player_turn = 1 - @player_turn
  end

  def to_s
    "Game"
  end
end

=begin

  X |   |        1 0 0    0 0 0
 ---+---+---
    | O |        0 0 0    0 1 0
 ---+---+---
  O |   | X      0 0 1    1 0 0

=end
