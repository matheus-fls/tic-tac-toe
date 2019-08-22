# frozen_string_literal: false

require_relative './game_state.rb'

class Player
  # Either O or X
  attr_reader :token
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
