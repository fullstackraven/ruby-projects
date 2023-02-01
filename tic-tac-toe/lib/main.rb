require 'ruby2d'

set title: 'Tic-Tac-Toe',
    width: 500,
    height: 500,
    resizable: true,
    background: 'random'

# Possible winning combinations
@winning_combinations = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8], # rows
  [0, 3, 6], [1, 4, 7], [2, 5, 8], # columns
  [0, 4, 8], [2, 4, 6] # diagonals
]

# Initialize a tic-tac-toe board with empty cells
@board_cells = Array.new(9, '')

# Initialize the player
@player = 'X'

# Method to reset the game
def reset_game
  clear
  @board_cells.map! { |cell| cell = '' }
  @player = 'X'
  play
end

# Method to ask the user if they want to play again
def repeat_game?
  on :key_down do |event|
    if event.key == 'x'
      reset_game
    else
      exit
    end
  end
end

# Method to determine if board is full and no winner
def full?
  @board_cells.count("") == 0
end

# Method to check if the game has ended
def game_ended?(board_cells)
  @winning_combinations.any? do |combination|
    combination.all? { |index| board_cells[index] == 'X' } ||
      combination.all? { |index| board_cells[index] == 'O' }
  end
end

# Method to display the winner
def display_winner(board_cells)
  @winning_combination = @winning_combinations.find do |combination|
    combination.all? { |index| board_cells[index] == 'X' } ||
      combination.all? { |index| board_cells[index] == 'O' }
  end

  if @winning_combination
    winner = @board_cells[@winning_combination[0]]
    if winner == 'X'
      display_winner_x
    else
      display_winner_o
    end
  end
  repeat_game?
end

# Ruby2D Method to handle displaying board and mouse clicks
def play
  # Displays game header
  title = Image.new(
    'img/game-logo.png',
    x: 0,
    y: -170,
    width: 500,
    height: 500
  )
  # Displays game board
  board = Image.new(
    'img/tic-tac-toe.png',
    x: 50,
    y: 120,
    width: 400,
    height: 400
  )
  on :mouse_down do |event|
    x = (event.x - 50) / 133
    y = (event.y - 100) / 133
    cell_index = y * 3 + x

    if @board_cells[cell_index] == '' && event.x > 60 && event.x < 440
      @board_cells[cell_index] = @player

      x = 50 + x * 133 + 33
      y = 100 + y * 133 + 33

      # Displays player symbol
      display = Text.new(
        @player,
        x: x,
        y: y,
        style: 'bold',
        size: 80,
        color: 'random',
        z: 1
      )

      if game_ended?(@board_cells)
        display_winner(@board_cells)
      elsif full?
        display_tie
        repeat_game?
      end

      @player = @player == 'X' ? 'O' : 'X'
    end
  end
end

def display_winner_x
  card1 = Rectangle.new(
    x: 50, y: 245,
    width: 410, height: 150,
    color: 'white',
    z: 1
  )
  text1 = Text.new(
    "GAME OVER!",
    x: 60,
    y: 245,
    style: 'bold',
    size: 60,
    color: 'red',
    z: 10
  )
  text2 = Text.new(
    "X IS THE WINNER",
    x: 88,
    y: 325,
    style: 'bold',
    size: 40,
    color: 'red',
    z: 10
  )
end

def display_winner_o
  card2 = Rectangle.new(
    x: 50, y: 245,
    width: 410, height: 150,
    color: 'white',
    z: 1
  )
  text3 = Text.new(
    "GAME OVER!",
    x: 60,
    y: 245,
    style: 'bold',
    size: 60,
    color: 'red',
    z: 10
  )
  text4 = Text.new(
    "O IS THE WINNER",
    x: 88,
    y: 325,
    style: 'bold',
    size: 40,
    color: 'red',
    z: 10
  )
end

def display_tie
  card3 = Rectangle.new(
    x: 50, y: 245,
    width: 410, height: 150,
    color: 'white',
    z: 1
  )
  text5 = Text.new(
    "It's a draw!",
    x: 60,
    y: 255,
    style: 'bold',
    size: 80,
    color: 'red',
    z: 1
  )
end

play

show
