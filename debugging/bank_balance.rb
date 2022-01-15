# Bank Balance

# require 'pry'

class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    new_balance = balance - amount
    if amount > 0 && valid_transaction?(new_balance)
      self.balance = new_balance
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    @balance = new_balance
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50

=begin

The problem lies in the fact that Ruby overrides the return value of the
`balance=` instance method. Any setter defined with the `setter=` syntax will
automatically return its argument (which usually represents the "set" value).

Therefore, upon the invocation of `withdraw` on line 57, the return value of
`balance=` is simply the new balance, which is an integer, This is assigned
to the local variable `success`, which will thus be evaluated as truthy in
the next line, stating that the transcation was made.

A fix for this is to move the logic for checking valid transactions outside of
that method.

Further Exploration: If we mutate the argument, the return value will still be
its argument -- just in mutated form.

=end