# frozen_string_literal: false

require_relative '../lib/game.rb'

RSpec.describe Game do
  let(:game) { Game.new }
  describe 'Game play' do
    it 'Changes state for every play' do
      game.play(0)
      expect(game.state).to eql('X23456789')
      game.play(8)
      expect(game.state).to eql('X2345678O')
    end

    it 'Toggles between 0 and 1 for player turn' do
      expect(game.player_turn).to eql(0)
      game.play(0)
      expect(game.player_turn).to eql(1)
      game.play(1)
      expect(game.player_turn).to eql(0)
    end

    it 'Checks for invalid moves' do
      expect(game.valid_moves).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
      expect(game.valid_move?(0)).to eql(true)
      game.play(0)
      expect(game.valid_moves).to eql([2, 3, 4, 5, 6, 7, 8, 9])
      expect(game.valid_move?(0)).to eql(false)
    end

    it 'Checks for winner state' do
      game.play(0)
      expect(game.winner).to eql(nil)
      game.play(1)
      expect(game.winner).to eql(nil)
      game.play(4)
      expect(game.winner).to eql(nil)
      game.play(5)
      expect(game.winner).to eql(nil)
      game.play(8)
      expect(game.winner).not_to be(nil)
      expect(game.winner.token).to eql('X')
    end

    it 'Checks for tie state' do
      game.play(0)
      game.play(4)
      game.play(8)
      game.play(3)
      game.play(5)
      game.play(2)
      game.play(6)
      game.play(7)
      expect(game.tie?).to be(false)
      game.play(1)
      expect(game.tie?).to be(true)
    end

    it 'Gets the next play from current player' do
      expect(game.fetch_current_player_move { 7 }).to eql(7)
    end

    it 'Checks for winner state' do
      game.play(0)
      game.play(1)
      game.play(4)
      game.play(5)

      game.store_state
      expect(game.winner).to eql(nil)
      expect(game.player_turn).to eql(0)

      game.play(8)
      expect(game.winner).not_to be(nil)

      game.restore_state
      expect(game.winner).to eql(nil)
      expect(game.player_turn).to eql(0)
    end
  end
end
