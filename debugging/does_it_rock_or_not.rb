# Does it Rock or Not

class AuthenticationError < StandardError; end

# A mock search engine
# that returns a random number instead of an actual count.
class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end

    rand(200_000)
  end

  private

  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'ABCD'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

      positive / (positive + negative)
    # Only rescue certain errors
    rescue ZeroDivisionError
      NoScore.new
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)

    case score
    when NoScore
      "No idea about #{term}..."
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue StandardError => e
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

=begin

When `find_out` is invoked, the `for_term` method is invoked, which invokes
the `count` method. Upon an invalid `api_key`, the `count` method does raise the
`AuthenticationError` as expected. However, when this error is handled is the
`rescue` clause in `count`, the `NoScore` class is returned. All of this is
expected behavior.

However, when the `case` statement in `find_out` compares a `score` whose value
is the `NoScore` class to `NoScore` itself, the comparison is performed using
the `#===` method (i.e. `NoScore === NoScore`). The way `===` is implemented by
default will automatically return false for this condition.

Therefore, possible solutions to this are:
- Don't use a `NoScore` class to indicate that the score was improperly
evaluated; instead use a symbol or string
- Raise an error instead
- Use an `if..else` statement for comparison instead of `case..when`

Lessons:
- Be *specific* when it comes to error handling
  - Raise specific errors
  - Handle specific errors (avoid catch-all error clauses)
  - Avoid rescuing all exceptions <== some errors SHOULD crash your program
    - Always subclass from StandardError and catch StandardErrors
- `#===` evaluates is something is an instance of something else -- it DOES NOT
compare for directly equality of classes

=end