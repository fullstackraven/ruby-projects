require_relative '../lib/connect_4.rb'

describe Connect4 do
  describe '#initialize' do
    it 'creates a new Connect4 object' do
      game = Connect4.new
      expect(game).to be_an_instance_of Connect4
    end

    it 'creates an empty board' do
      game = Connect4.new
      expect(game.instance_variable_get(:@board)).to eq([
        ["-", "-", "-", "-", "-", "-", "-"],
        ["-", "-", "-", "-", "-", "-", "-"],
        ["-", "-", "-", "-", "-", "-", "-"],
        ["-", "-", "-", "-", "-", "-", "-"],
        ["-", "-", "-", "-", "-", "-", "-"],
        ["-", "-", "-", "-", "-", "-", "-"]
      ])
    end

    it 'sets the current player to X' do
      game = Connect4.new
      expect(game.instance_variable_get(:@current_player)).to eq('X')
    end
  end

  describe '#get_player_input' do
    before do
      @game = Connect4.new
    end

    it 'prompts the current player to choose a column' do
      expect do
        allow(@game).to receive(:gets).and_return("1\n")
        @game.get_player_input
      end.to output("Player X, choose a column to drop your piece into (1-7):\n").to_stdout
    end

    it 'rejects invalid input' do
      expect do
        allow(@game).to receive(:gets).and_return("a\n", "1\n")
        @game.get_player_input
      end.to output("Player X, choose a column to drop your piece into (1-7):\n" + "Invalid input. Please choose a valid column that is not already full.\n" + "Player X, choose a column to drop your piece into (1-7):\n").to_stdout
    end

    it 'accepts valid input' do
      expect do
        allow(@game).to receive(:gets).and_return("1\n")
        @game.get_player_input
      end.to output("Player X, choose a column to drop your piece into (1-7):\n").to_stdout
    end
  end
end