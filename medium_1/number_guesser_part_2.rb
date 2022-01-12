# Number Guesser

=begin

Problem:
- Extend functionality to allow for a custom MIN_GUESS and MAX_GUESS
- Number of guesses should be computed such that the player can win guaranteed

Note: Playing the game in a binary search fashion => guaranteed to guess #
after `log2(RANGE_SIZE) + 1`` guesses (narrow down to one # by halfing that
# times)

=end

class GuessingGame
  MESSAGES = {
    invalid_guess: "Your guess is invalid.",
    high_guess: "Your guess is too high.",
    low_guess: "Your guess is too low.",
    win: "That's the number!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize(min_guess, max_guess)
    @range = min_guess..max_guess
    @max_number_guesses = compute_max_guesses
    @target = nil
    @result = nil
  end

  def compute_max_guesses
    Math.log2(range.size - 1).to_i + 1
  end

  def play
    setup
    make_guess
    dipslay_result
  end

  def setup
    self.target = random_target
    self.result = :lose
  end

  def random_target
    rand(range)
  end

  def make_guess
    max_number_guesses.downto(1) do |num_guesses|
      display_guesses_remaining(num_guesses)
      guess = retrieve_guess
      display_feedback(guess)

      if guess == target
        self.result = :win
        break
      end
    end
  end

  def retrieve_guess
    guess = nil

    loop do
      print "Enter a number between #{range.min} and #{range.max}: "
      guess = gets.chomp.to_i
      break if range.cover?(guess)
      print MESSAGES[:invalid_guess]
    end

    guess
  end

  def display_guesses_remaining(guesses)
    puts "You have #{guesses} guess#{guesses > 1 ? 'es' : ''} remaining."
  end

  def display_feedback(guess)
    if guess > target
      puts MESSAGES[:high_guess]
    elsif guess < target
      puts MESSAGES[:low_guess]
    end
    puts
  end

  def dipslay_result
    puts MESSAGES[result]
  end

  private

  attr_reader :range, :max_number_guesses
  attr_accessor :target, :result
end

game = GuessingGame.new(501, 1500)
game.play
