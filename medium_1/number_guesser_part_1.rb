# Number Guesser

=begin

Nouns:
- Guess (number)
- Num guesses
- Target #

Verbs:
- Guess
  - *only allow if remaining guesses*
- Feedback
- Display

Should we store a `@guess` instance variable?
- Pro: Allows us access when we need to display the result
- Con: It doesn't really make sense to be stored in the context of the entire
game -- it's sort of just specific to each round

=end

# Next step: Refactor (e.g. constants)

class GuessingGame
  MIN_GUESS = 1
  MAX_GUESS = 100
  NUM_GUESSES = 7

  MESSAGES = {
    enter_number: "Enter a number between #{MIN_GUESS} and #{MAX_GUESS}: ",
    invalid_guess: "Your guess is invalid.",
    high_guess: "Your guess is too high.",
    low_guess: "Your guess is too low.",
    win: "That's the number!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize
    @target = nil
    @result = nil
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
    Random.new.rand(MIN_GUESS..MAX_GUESS)
  end

  def make_guess
    NUM_GUESSES.downto(1) do |num_guesses|
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
      print MESSAGES[:enter_number]
      guess = gets.chomp.to_i
      break if (MIN_GUESS..MAX_GUESS).cover?(guess)
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

  attr_accessor :target, :result
end

game = GuessingGame.new
game.play

=begin

Further Exploration

Should we implement a `Player` class?

Because of the simplicity of this game, a `Player` class is not really needed.
That said, having a `Player` could be useful in the following ways:

1. Store the state of the guess of the player => guess can be accessed when:
  - Determining result of guess
  - Determining result of match
  - Displaying result of match
2. Adding more player-specific functionality -- e.g. player name, history, etc.
3. Adding multiple players to the game

I would store the `Player` as a collaborative object as part of the
`GuessingGame` class. It would contain the current guess, methods for guess
retrieval, and the number of guesses left that player has.

=end