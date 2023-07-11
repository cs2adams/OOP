class GuessingGame

  def initialize(range_min, range_max)
    @min = range_min
    @max = range_max
    @num = new_number
    @num_guesses = num_allowable_guesses
    @guess = nil
  end

  def play
    self.num_guesses = num_allowable_guesses
    self.num = new_number
    
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

  attr_accessor :num_guesses, :guess, :num
  attr_reader :min, :max

  def prompt_guess
    puts ""
    puts "You have #{num_guesses} guesses remaining."
    print "Enter a number between #{min} and #{max}: "
  end

  def take_a_guess
    current_guess = 0
    loop do
      current_guess = gets.chomp.to_i
      break if valid_guess?(current_guess)
      print "Invalid guess. Enter a number between #{min} and #{max}: "
    end
    self.guess = current_guess
  end

  def valid_guess?(current_guess)
    (min..max).include?(current_guess)
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
    rand(min..max)
  end

  def num_allowable_guesses
    Math.log2(max - min).to_i + 1
  end
end

game = GuessingGame.new(501, 1500)
game.play
game.play