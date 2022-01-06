# Fix the Program

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

=begin

`attr_accessor` creates a writer method for `@database_handle`. It is unlikely
that the database handle for a flight should change. This could be problematic
if an outside developer maliciously wants to mismatch the flights, and associate
a flight with a different database handle. This should really be a private
concern -- there is no reason for a unique identifier like a database handle
to be changed.

Access could also be a problem if a user decides to use that database handle
for other purposes.

Furthermore, the way it is implemented offers no flexibility when it comes to
using a database. Whenever a `Flight` is initialized, a `Database` handle is
created. If in the future, a database is not used, then the `initialize` method
would have to be updated. It would be better for `@database_handle` to be set
independent of initialization.

=end