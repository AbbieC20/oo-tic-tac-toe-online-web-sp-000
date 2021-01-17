class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], #Top row
    [3,4,5], #Middle row
    [6,7,8], #Bottom row
    [0,3,6], #First column
    [1,4,7], #Second column
    [2,5,8], #Third column
    [0,4,8], #LR Diagonal
    [2,4,6], #RL Diagonal
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(player_input)
      player_input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    if @board[index] == " " || @board[index] == ""  #board position is empty and so available
      return false
    else
      return true
    end
  end

  def valid_move?(index)
    if index.between?(0,8) && !self.position_taken?(index) # grid square is on the board OR not already played
      return true
    else
      return false
    end
  end

  def turn_count
    @board.count {|token| token == "X" || token == "O"}
  end

  def current_player
    self.turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter your turn (between 1-9)"
    input = gets.strip
    index = self.input_to_index(input)
    if self.valid_move?(index) == true
      token = self.current_player
      self.move(index, token)
      self.display_board
    else
      self.turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      all_positions_taken = win_combination.all? { |position| self.position_taken?(position) }
      position_tokens = win_combination.map { |position| @board[position]}
      if all_positions_taken == true && position_tokens.uniq.length == 1
        return win_combination
      end
    end
    return false
  end

  def full?
    @board.each_with_index do |token, board_position|
      if self.position_taken?(board_position) == false
        return false
      end
    end
    return true
  end

  def draw?
    if self.full? == false
      return false
    elsif self.won? != false
      return false
    else
      return true
    end
  end

  def over?
    if self.won? != false
      return true
    elsif self.draw? == true
      return true
    else
      return false
    end
  end

  def winner
    winning_combination = self.won?
    if winning_combination != false
      winning_position = winning_combination[0]
      return @board[winning_position]
    else
      return nil
    end
  end

end #CLASS END
