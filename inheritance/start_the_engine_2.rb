# Start the Engine (Part 2)

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed}, please!" # Must identify () to avoid passing arguments
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')