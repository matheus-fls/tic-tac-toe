# frozen_string_literal: true

require_relative '../lib/game.rb'

RSpec.describe AIPlayer do
  let(:game) { Game.new.with_auto_play }
  describe 'AI' do
    it 'Plays a consistent tic-tac-toe' do
      until game.winner || game.tie?
        computed_move = game.fetch_current_player_move
        expect([1, 2, 3, 4, 5, 6, 7, 8, 9].any?(computed_move)).to be(true)
        game.play(computed_move - 1)
      end
      expect(!game.winner.nil? || game.tie?).to be(true)
    end
  end
end
