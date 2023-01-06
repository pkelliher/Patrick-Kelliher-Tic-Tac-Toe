class TicTacToeGame
  VICTORY = [
    [0, 1, 2], # same gp top row.
    [3, 4, 5], # same gp middle row.
    [6, 7, 8], # same gp bottom row.
    [0, 3, 6], # same gp left column.
    [1, 4, 7], # same gp center column.
    [2, 5, 8], # same gp right column.
    [0, 4, 8], # same gp left diagonal.
    [6, 4, 2]  # same gp right diagnal.
  ]

  attr_accessor :board

  def initialize
    @board = [*1..9]
    @remaining_spaces = 9
  end

  def remove_space
    @remaining_spaces -= 1
  end

  def remaining_spaces
    @remaining_spaces
  end

end

class Player
  attr_reader :name, :game_piece

  def initialize(name, game_piece)
    @name = name
    @game_piece = game_piece
  end
end

board = TicTacToeGame.new

def intro_message
  puts ''
  puts 'XOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXO'
  puts 'XO  Welcome to Patrick\'s Tic Tac Toe! XO'
  puts 'XOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXO'
  puts ''
end

def display_board(board)
  puts ''
  puts " #{board.board[0]} | #{board.board[1]} | #{board.board[2]} "
  puts '---x---o---'
  puts " #{board.board[3]} | #{board.board[4]} | #{board.board[5]} "
  puts '---o---x---'
  puts " #{board.board[6]} | #{board.board[7]} | #{board.board[8]} "
  puts ''
end

def create_player(player_num, game_piece)
  print "Hello player #{player_num} please enter your first name: "
  name = gets.strip.capitalize
  puts "Welcome, #{name}; your game piece will be #{game_piece}"
  puts ''
  Player.new(name, game_piece)
end

def make_move(board, player)
  print "#{player.name}, it's your turn; please select a location on the board between (1 and 9): "
  position = gets.chomp.to_i - 1
  board.board[position] = player.game_piece
  board.remove_space
end

def check_win(board, player)
  counter = 0
 TicTacToeGame::VICTORY.each do |win_state|
    win_state.each do |position|
      counter += 1 if board.board[position] == player.game_piece
    end
    if counter >= 3
      display_board(board)
      puts "Congratulations, #{player.name}, you won!"
      return true
    else
      counter = 0
    end
  end
end

def play_turn(player, board)
  display_board(board)
  make_move(board, player)
  check_win(board, player) == true
end

def play_game(board)
  intro_message
  player1 = create_player(1, "X")
  player2 = create_player(2, "O")

  turn = 1
  loop do
    case
    when turn == 1
      turn = 2
      break if play_turn(player1, board)
    when turn == 2
      turn = 1
      break if play_turn(player2, board)
    end
    if board.remaining_spaces.zero?
      puts "Cat's game, there is no winner."
      break
    end
  end
end

play_game(board)