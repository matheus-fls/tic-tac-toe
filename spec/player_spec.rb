# frozen_string_literal: false

require_relative '../lib/player.rb'

RSpec.describe Player do
  let(:player) { Player.new('X') }
  describe 'Player game state' do
    it 'Identifies a winning state' do
      [0, 2, 4, 6, 8].each { |pos| player.play(pos) }
      expect(player.winner?).to eql(true)
    end

    it 'Identifies a winning state' do
      [1, 3, 5, 7].each { |pos| player.play(pos) }
      expect(player.winner?).to eql(false)
    end

    it 'Identifies a valid move' do
      [0, 2, 4, 6, 8].each { |pos| player.play(pos) }
      expect(player.valid_move?(2)).to eql(false)
      expect(player.valid_move?(3)).to eql(true)
    end

    it "Returns the player's current state" do
      [0, 2, 4, 6, 8].each { |pos| player.play(pos) }
      expect(player.reflect_state('_________')).to eql('X_X_X_X_X')
    end

    it 'Saves and restore state' do
      player.play(8)
      expect(player.to_s).to eql("Player 'X' (1)")
      player.store_state
      player.play(0)
      expect(player.to_s).to eql("Player 'X' (257)")
      player.restore_state
      expect(player.to_s).to eql("Player 'X' (1)")
    end

    it 'Gets the next play' do
      expect(player.fetch_play(nil) { 7 }).to eql(7)
    end
  end
end
