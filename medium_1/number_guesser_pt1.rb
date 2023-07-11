class GuessingGame
  MAX_GUESSES = 7
  MIN = 1
  MAX = 100

  def initialize
    @num = new_number
    @num_guesses = 7
    @guess = nil
  end

  def play
    self.num_guesses = MAX_GUESSES
    new_number
    
    while num_guesses > 0
      prompt_guess
      take_a_guess
      display_guess_result
      break if guessed_correctly?
      one_less_guess
    end

    if guessed_correctly?
      puts "\nYou won!"
    else
      puts "\nYou have no more guesses. You lost!"
    end
  end

  private

  attr_accessor :num_guesses, :guess
  attr_reader :num

  def prompt_guess
    puts ""
    puts "You have #{num_guesses} guesses remaining."
    print "Enter a number between #{MIN} and #{MAX}: "
  end

  def take_a_guess
    current_guess = 0
    loop do
      current_guess = gets.chomp.to_i
      break if valid_guess?(current_guess)
      print "Invalid guess. Enter a number between #{MIN} and #{MAX}: "
    end
    self.guess = current_guess
  end

  def valid_guess?(current_guess)
    (MIN..MAX).include?(current_guess)
  end
  
  def guessed_correctly?
    guess == num
  end

  def display_guess_result
    puts "Your guess is too high" if guess > num
    puts "Your guess is too low" if guess < num
    puts "That's the number!" if guessed_correctly?
  end

  def one_less_guess
    self.num_guesses -= 1
  end

  def new_number
    @num = rand(MIN..MAX)
  end
end

game = GuessingGame.new
game.play
game.play