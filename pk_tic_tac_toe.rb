class TicTacToeGame
  attr_accessor :board

  def initialize
    @board = [*1..9]
    @@remaining_spaces = 9
  end

  def self.remove_space
    @@remaining_spaces -= 1
  end

  def self.remaining_spaces
    @@remaining_spaces
  end

  puts ''
  puts 'XOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXO'
  puts 'XO  Welcome to Patrick\'s Tic Tac Toe! XO'
  puts 'XOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXOXO'
  puts ''
end

class Player
  attr_reader :name, :game_piece

  def initialize(name, game_piece)
    @name = name
    @game_piece = game_piece
  end
end

board = TicTacToeGame.new
player1 = Player
player2 = Player

def display_board(board)
  puts " #{board.board[0]} | #{board.board[1]} | #{board.board[2]} "
  puts '---x---o---'
  puts " #{board.board[3]} | #{board.board[4]} | #{board.board[5]} "
  puts '---o---x---'
  puts " #{board.board[6]} | #{board.board[7]} | #{board.board[8]} "
end

def create_player1(player1)
  print 'Hello player 1, please enter your first name: '
  name = gets.chomp.capitalize
  puts "Welcome, #{name}; your game piece will be 'X'."
  puts ''
  game_piece = 'X'
  player1.new(name, game_piece)
end

def create_player2(player2)
  print 'Hello player 2, please enter your first name: '
  name = gets.chomp.capitalize
  puts "Welcome, #{name}; your game piece will be 'O'."
  puts ''
  game_piece = 'O'
  player2.new(name, game_piece)
end

def make_move(board, player)
  puts 'please select a location on the board between (1 and 9).'
  position = gets.chomp.to_i - 1
  board.board[position] = player.game_piece
  TicTacToeGame.remove_space
end

def check_win(board, player, victory)
  counter = 0
  for win_state in victory
    for position in win_state
      counter += 1 if board.board[position] == player.game_piece
    end
    if counter >= 3
      p ''
      puts "Congratulations, #{player.name}, you won!"
      return true
    else
      counter = 0
    end
  end
end

def play_turn(player, board, victory)
  print "#{player.name}, it's your turn; "
  make_move(board, player)
  display_board(board)
  check_win(board, player, victory) == true
end

def play_game(board, player1, player2)
  victory = [
    [0, 1, 2], # same gp top row.
    [3, 4, 5], # same gp middle row.
    [6, 7, 8], # same gp bottom row.
    [0, 3, 6], # same gp left column.
    [1, 4, 7], # same gp center column.
    [2, 5, 8], # same gp right column.
    [0, 4, 8], # same gp left diagonal.
    [6, 4, 2]  # same gp right diagnal.
  ]
  player1 = create_player1(player1)
  player2 = create_player2(player2)

  turn = 1
  loop do
    case
    when turn == 1
      turn = 2
      break if play_turn(player1, board, victory)
    when turn == 2
      turn = 1
      break if play_turn(player2, board, victory)
    end
    if TicTacToeGame.remaining_spaces.zero?
      puts "Cat's game, there is no winner."
      break
    end
  end
end

play_game(board, player1, player2)