# Stack Machine Interpreation

=begin

Summary:

We have a compiler that has a state with a stack and a register. We need to
update the stack and register based on a variety of commands. If the command is
not available to the the program, raise an error. If the command tries to pop
from an empty stack, immediately exit the program.

Requirements:
- For each token, an error must be raised if:
  - The token is invalid OR
  - The command doesn't work, because the stack is empty

Questions:
- Where to use Object#send? Idea: send the lowercase version of current command?
- Any other classes needed?

Ideas:
- Stack is its own class; inherits from Array
  - Override standard `pop` method to raise an error
- Use Object#send to convert text of token to callable method on the class
  - MiniLang has access to Object#send, so it can be used

=end

# Solution 1: Using a case statement

=begin

...
  def evaluate(token)
    case token
    when /\A[-+]?\d+\z/ then self.register = token.to_i
    when 'ADD'          then self.register += stack.pop
    when 'DIV'          then self.register /= stack.pop
    when 'MULT'         then self.register *= stack.pop
    when 'MOD'          then self.register %= stack.pop
    when 'SUB'          then self.register -= stack.pop
    when 'PUSH'         then stack.push(register)
    when 'POP'          then self.register = stack.pop
    when 'PRINT'        then puts register
    else                raise InvalidTokenError, "Invalid token: #{token}"
    end
  end
...

=end

class MinilangError < StandardError; end
class InvalidTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  COMMANDS = %w(ADD DIV MULT MOD SUB PUSH POP PRINT)

  def initialize(program)
    @program = program
  end

  def eval(params = {})
    self.register = 0
    self.stack = Stack.new
    format(program, params).split.each { |token| eval_token(token) }
  rescue MinilangError => e
    puts e.message
  end

  def eval_token(token)
    if COMMANDS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      self.register = token.to_i
    else
      raise InvalidTokenError, "Invalid token: #{token}"
    end
  end

  def add
    self.register += stack.pop
  end

  def div
    self.register /= stack.pop
  end

  def mult
    self.register *= stack.pop
  end

  def mod
    self.register %= stack.pop
  end

  def sub
    self.register -= stack.pop
  end

  def push
    stack.push(register)
  end

  def pop
    self.register = stack.pop
  end

  def print
    puts register
  end

  private

  attr_accessor :register, :stack, :program
end

class Stack < Array
  def pop
    raise EmptyStackError, "Empty stack!" if empty?
    super
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

# Further Exploration 1

=begin

Goal: Allow the program to take input values (arguments)

How?
- Add parameter to MiniLang#eval
- Set the `program` accordingly

=end

CENTIGRADE_TO_FAHRENHEIT = 
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40

# Compute area of rectangle

RECTANGLE_AREA = '%<length>d PUSH %<width>d MULT PRINT'

compute_area = Minilang.new(RECTANGLE_AREA)
compute_area.eval(length: 10, width: 20)
compute_area.eval(length: 5, width: 10)

# Further Exploration 2

=begin

Problem: In the LS solution, the commands invoke the `pop` method, which has an
unnecessary intermediate step of setting the register to the value that was 
popped off the stock. In a method like `add`, we never really want that behavior
to occur: we simply want to increment the register by the popped value. We
never want to set it to the popped value itself.

What's the problem?

Take the `add` method:

`@register += pop` is `@register = @register + pop`. 

The implicit return value of `pop` is `@stack.pop` -- the popped value. 

It works fine, but only because of the order in which Ruby breaks down the code,
making the code a bit unclear.

In order to avoid this behavior, we can not use the `pop` method as it is
implemented currently, since it sets the `@register` to `@stack.pop`, which is
the unnecessary intermediate step.

One solution would be to avoid using the `Minilang#pop` instance method for the
`add`, `div`, `mod`, `mult` etc. commands -- this #pop should only be used
when we explicitly want to set the register to a value popped from the stack.

Ideally, we could just call the `Array#pop` method directly on the stack,
instead of calling `pop` -- but we need the error-handling functionality.

One way to do this would be to create a new class,
`Stack` that inherits from `Array`, and simply override the inherited
`Array#pop` method. This way, we can perform the error-checking without
setting the `@register` -- we can leave that to the `Minilang#pop` method.

=end