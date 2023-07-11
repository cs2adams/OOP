class Player
  attr_reader :num_guesses, :guess

  def initialize
    @guess = nil
    @num_guess = 7
  end

  def take_a_guess
    current_guess = 0
    loop do
      current_guess = gets.chomp.to_i
      break if GuessingGame.valid_guess?(current_guess)
      print "Invalid guess. Enter a number between #{MIN} and #{MAX}: "
    end
    self.guess = current_guess
  end

  def one_less_guess
    self.num_guesses -= 1
  end

  def reset
    self.guess = nil
    self.num_guesses = 7
  end

  private

  attr_writer :num_guesses, :guess

end

class GuessingGame
  MAX_GUESSES = 7
  MIN = 1
  MAX = 100

  def initialize
    @player = Player.new
    @num = new_number
  end

  def play
    reset
    main_game_loop
    display_final_result
  end

  def self.valid_guess?(current_guess)
    (MIN..MAX).include?(current_guess)
  end

  private

  attr_reader :player
  attr_accessor :num

  def main_game_loop
    while player.num_guesses > 0
      prompt_guess
      player.take_a_guess
      display_guess_result
      break if guessed_correctly?
      player.one_less_guess
    end
  end

  def prompt_guess
    puts ""
    puts "You have #{player.num_guesses} guesses remaining."
    print "Enter a number between #{MIN} and #{MAX}: "
  end
  
  def guessed_correctly?
    player.guess == num
  end

  def display_guess_result
    puts "Your guess is too high" if player.guess > num
    puts "Your guess is too low" if player.guess < num
    puts "That's the number!" if guessed_correctly?
  end

  def display_final_result    
    if guessed_correctly?
      puts "\nYou won!"
    else
      puts "\nYou have no more guesses. You lost!"
    end
  end

  def reset
    player.reset
    self.num = new_number
  end

  def new_number
    rand(MIN..MAX)
  end
end

game = GuessingGame.new
game.play
game.play