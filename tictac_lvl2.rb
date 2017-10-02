def tictac
  welcome = "\nWelcome to our Tic Tac Toe game!"
  puts welcome
  grid = ['0', '1', '2', '3', '4', '5', '6', '7', '8']
  n = 0 # counter for our main loop
  computer_or_human = who_plays # check if user/user or user/computer
  # decide who starts the game, and only if it's user/computer
  starter = who_starts if computer_or_human == 'c'
  showgrid(grid) # display initial grid
  while n < 9
    if computer_or_human == 'h'
      p_input = ask_p # request and store user choice of position
    elsif computer_or_human == 'c'
      if starter == 'Y' # this flow if user starts
        if n.even? # round "0" / basically first player
          p_input = ask_p
        elsif n.odd? # round "1" and other odd / basically second player
          p_input = computer_input(grid) # take "choice" from computer
          puts 'Computer has played:'
        end
      elsif starter == 'N' # we just flip around the order of starting
        if n.odd?
          p_input = ask_p
        elsif n.even?
          p_input = computer_input(grid)
          puts 'Computer has played:'
        end
      end
    end
    if p_input == 'exit' # to exit the game if user types exit
      puts 'See you!'
      break
    elsif p_input == 'reset' # to restart the game, we have to include all the initial stuff
      n = 0
      puts welcome
      grid = ['0', '1', '2', '3', '4', '5', '6', '7', '8']
      computer_or_human = who_plays # check if user/user or user/computer
      # decide who starts the game, and only if it's user/computer
      starter = who_starts if computer_or_human == 'c'
      showgrid(grid) # display initial grid
      next
    else
      grid = change_the_grid(grid, n, p_input) # puts in X and O (state)
      if check_win(grid) == true
        showgrid(grid) # display the grid
        break # if there is a win
      end
    end
    puts "It's a draw!" if n == 8 && check_win(grid) == false # 9 turns over, no win
    showgrid(grid) # display the grid
    n += 1
  end
end

def showgrid(grid) # displays the grid in the right format!
  print " #{grid[0]} | #{grid[1]} | #{grid[2]}\n"
  print '-' * 9 + "\n"
  print " #{grid[3]} | #{grid[4]} | #{grid[5]}\n"
  print '-' * 9 + "\n"
  print " #{grid[6]} | #{grid[7]} | #{grid[8]}\n\n"
end

def who_plays # decide if user/user or user/computer
  print "Type 'c' to play against the computer or 'h' for only humans!\n"
  gets.chomp
end

def who_starts # decide who starts if user/computer
  puts 'Do you want to start? (Y/N)'
  gets.chomp
end

def ask_p # getting user input
  print "Enter a number (or type 'exit' to leave the game, 'reset' to restart): "
  gets.chomp
end

def computer_input(grid)
  prng = Random.new
  computer_num = prng.rand(9) # generate a random number between 0 and 8
  # generate new random if the spot is occupied
  while grid[computer_num] == 'X' || grid[computer_num] == 'O'
    computer_num = prng.rand(9)
  end
  computer_num
end

def change_the_grid(grid, n, p_input) # 1) chooses X or O, 2) replaces array items
  # error checking, prevent duplicate entries for humans
  while grid[p_input.to_i] == 'X' || grid[p_input.to_i] == 'O'
    puts "Oh no that spot's already taken!"
    p_input = ask_p # have to ask user for input again
    if p_input == 'exit'
      puts 'See you!'
      exit # exit the program
    end
  end
  # choose X or O
  grid[p_input.to_i] = if n.odd?
                         'O'
                       else
                         'X'
                       end
  grid
end

def check_win(grid)
  # case for checking against win combo
  if grid[0] == grid[1] && grid[0] == grid[2]
    game_win = true
    winner = grid[0]
  elsif grid[0] == grid[4] && grid[0] == grid[8]
    game_win = true
    winner = grid[0]
  elsif grid[0] == grid[3] && grid[0] == grid[6]
    game_win = true
    winner = grid[0]
  elsif grid[2] == grid[4] && grid[2] == grid[6]
    game_win = true
    winner = grid[2]
  elsif grid[2] == grid[5] && grid[2] == grid[8]
    game_win = true
    winner = grid[2]
  elsif grid[6] == grid[7] && grid[6] == grid[8]
    game_win = true
    winner = grid[6]
  elsif grid[1] == grid[4] && grid[1] == grid[7]
    game_win = true
    winner = grid[1]
  elsif grid[3] == grid[4] && grid[3] == grid[5]
    game_win = true
    winner = grid[3]
  else
    game_win = false
  end
  if game_win == true
    puts "Player #{winner} won!"
    true
  else
    false
  end
end

tictac
