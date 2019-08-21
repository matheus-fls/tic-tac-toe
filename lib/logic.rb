# frozen_string_literal: false

def bin_converter(state)
  state.reduce(0) { |acc, value| acc * 2 + value }
end

WINNER_STATES = [

  [1, 0, 0,
   1, 0, 0,
   1, 0, 0],

  [0, 1, 0,
   0, 1, 0,
   0, 1, 0],

  [0, 0, 1,
   0, 0, 1,
   0, 0, 1],

  [1, 1, 1,
   0, 0, 0,
   0, 0, 0],

  [0, 0, 0,
   1, 1, 1,
   0, 0, 0],

  [0, 0, 0,
   0, 0, 0,
   1, 1, 1],

  [1, 0, 0,
   0, 1, 0,
   0, 0, 1],

  [0, 0, 1,
   0, 1, 0,
   1, 0, 0]

].map { |state| bin_converter(state) }

class GameState
  def initialize
    @board = [0, 0, 0,
              0, 0, 0,
              0, 0, 0]
  end

  # Will determine if it's a winning state

  def winner?
    b = bin_converter(@board)
    WINNER_STATES.any? do |a|
      a & b == a
    end
  end

  def play(cell)
    @board[cell] = 1
  end

  def valid_move?(cell)
    @board[cell].zero?
  end

  def reflect_state(str, token)
    @board.each_with_index { |state, index| str[index] = token if state == 1 }
    str
  end
end

class Player
  # Either O or X
  def initialize(token)
    @token = token
    @state = GameState.new
  end

  def winner?
    @state.winner?
  end

  def valid_move?(cell)
    @state.valid_move?(cell)
  end

  def play(cell)
    @state.play(cell)
  end

  def reflect_state(str)
    @state.reflect_state(str, @token)
  end

  def to_s
    "Player '#{@token}'"
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
