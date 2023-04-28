class Connect4

    def initialize
      say_hello
      @board = Array.new(6) { Array.new(7, "-") }
      @current_player = 'X'
    end

    def say_hello
        puts " "
        puts '         CONNECT 4'
        puts " "
      end

    def get_player_input
        valid_input = false
        while !valid_input
          puts "Player #{@current_player}, choose a column to drop your piece into (1-7):"
          column = gets.chomp.to_i
          if column >= 1 && column <= 7 && @board[0][column-1] == "-"
            valid_input = true
          else
            puts "Invalid input. Please choose a valid column that is not already full."
          end
        end
      column
    end

    def display_board
        column_numbers = "  1   2   3   4   5   6   7"
        row_separator = "+---+---+---+---+---+---+---+"
        puts column_numbers
        puts row_separator
        @board.each do |row|
          row_display = "|"
          row.each do |cell|
            row_display += " #{cell} |"
          end
          puts row_separator
          puts row_display
        end
        puts row_separator
      end

    def update_board(column)
        row = 5
        while row >= 0
          if @board[row][column-1] == "-"
            @board[row][column-1] = @current_player
            break
          else
            row -= 1
          end
        end
        if row == -1
          puts "Error: Column is already full."
          return false
        else
          return true
        end
    end

    def check_for_win(row, column)
        # Check row
        row_string = @board[row].join("")
        if row_string.include?(@current_player * 4)
          return true
        end
    
        # Check column
        column_string = ""
        @board.each do |row|
          column_string += row[column-1]
        end
        if column_string.include?(@current_player * 4)
          return true
        end
    
        # Check diagonal
        diagonal_string1 = ""
        diagonal_string2 = ""
        (0..5).each do |i|
          (0..6).each do |j|
            if i-j == row-column
              diagonal_string1 += @board[i][j]
            end
            if i+j == row+column
              diagonal_string2 += @board[i][j]
            end
          end
        end
        if diagonal_string1.include?(@current_player * 4) || diagonal_string2.include?(@current_player * 4)
          return true
        end
    
        return false
      end

    def play_game
        winner = nil
        while winner.nil?
          display_board
          column = get_player_input
          updated = update_board(column)
          if updated
            if check_for_win(5, column)
              winner = @current_player
            else
              if @current_player == "X"
                @current_player = "O"
              else
                @current_player = "X"
              end
            end
            if @board.all? { |row| row.none?("-") }
              winner = "Tie"
            end
          end
        end
        display_board
        if winner == "Tie"
          puts "The game is a tie!"
        else
          puts "Congratulations, Player #{winner}, you win!"
        end
    end
end

game = Connect4.new
game.play_game
