WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
    user_input.to_i - 1
end

def move(board, index, value)
    board[index] = value
end

def position_taken?(board, index)
    if board[index] == " " || board[index] == "" || board[index] == nil 
        false
    else
        true 
    end 
end

def valid_move?(board, index)
    if position_taken?(board, index) == false && index.between?(0, 8)
        true
    end
end

def turn_count(board)
    counter = 0
    board.each do |token|
        if token == "O" || token == "X" 
            counter += 1 
        end 
    end
    counter
end

def current_player(board)
    if turn_count(board) % 2 != 0
        "O"
    elsif turn_count(board) % 2 == 0 
        "X"
    end 
end

def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.chomp 
    index = input_to_index(user_input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
    else 
        turn(board)
    end 
    display_board(board)
end

def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]
  
      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]
  
      if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 =="O" && position_2 == "O" && position_3 == "O"
        return win_combination
      end
    end
    false
  end

  def full?(board)
    board.all? {|space| space == "X" || space == "O"}
  end

  def draw?(board)
    if full?(board) && !won?(board)
      return true
    else 
      return false
    end 
  end

  def over?(board)
    if draw?(board) || won?(board) || full?(board) 
      return true
    else
      return false
    end
  end

  def winner(board)
    if won?(board)
      return board[won?(board)[0]]
    end
  end

  def play(board)
    turn(board) until over?(board)
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board) 
        puts "Cat's Game!"
  end 
end 