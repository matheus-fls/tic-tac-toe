# frozen_string_literal: false

require_relative '../lib/game_state.rb'

RSpec.describe GameState do
  let(:game_state) { GameState.new }
  describe 'Player game state' do
    it 'Start filled with zeroes' do
      expect(game_state.to_i).to eql(0)
    end

    it 'First position is highest index' do
      game_state.play(0)
      expect(game_state.to_i).to eql(256)
    end

    it 'Last position is lowest index' do
      game_state.play(8)
      expect(game_state.to_i).to eql(1)
    end

    it 'Identifies a winning state' do
      [0, 2, 4, 6, 8].each { |pos| game_state.play(pos) }
      expect(game_state.winner?).to eql(true)
    end

    it 'Identifies a winning state' do
      [1, 3, 5, 7].each { |pos| game_state.play(pos) }
      expect(game_state.winner?).to eql(false)
    end

    it 'Identifies a valid move' do
      [0, 2, 4, 6, 8].each { |pos| game_state.play(pos) }
      expect(game_state.valid_move?(2)).to eql(false)
      expect(game_state.valid_move?(3)).to eql(true)
    end

    it 'Identifies a valid move' do
      [0, 2, 4, 6, 8].each { |pos| game_state.play(pos) }
      expect(game_state.reflect_state('_________', 'X')).to eql('X_X_X_X_X')
    end

    it 'Saves and restore state' do
      game_state.play(8)
      expect(game_state.to_i).to eql(1)
      game_state.store_state
      game_state.play(0)
      expect(game_state.to_i).to eql(257)
      game_state.restore_state
      expect(game_state.to_i).to eql(1)
    end
  end
end
