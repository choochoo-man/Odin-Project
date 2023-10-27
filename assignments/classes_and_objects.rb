# frozen_string_literal: true

# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define
# some instance variables that tell us the year, color, and model of the car.
# Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well.
# Create instance methods that allow the car to speed up, brake, and shut the car off.

module TruckHorn
  def horn
    puts 'Beep beep'
  end
end

class Vehicle
  # attr_reader :vehicles
  @@vehicles = 0

  def initialize(year, color, model)
    # @vehicles ||= 0
    @year = year
    @color = color
    @model = model
    @speed = 0
    @time = Time.new
    @@vehicles += 1
  end

  def self.vehicle_number
    "#{@@vehicles} created"
  end

  def spray_paint(color)
    self.color = color
    "your new #{color} paint looks nice"
  end

  def speed_up(speed_up)
    @speed += speed_up.to_i
  end

  def brake(braking)
    @speed -= braking.to_i
  end

  def shut_off(_car_name)
    @speed = 0
  end

  def gas_mileage(gallons, miles)
    puts "#{miles.to_f / gallons} miles per gallon"
  end

  def age
    puts "This vehicle is #{veh_age} years old"
  end

  private

  def veh_age
    Time.now.year - year
  end
end

class MyCar < Vehicle
  attr_accessor :color
  attr_reader :year

  SIZE = 'Small'

  def view_year
    "your car was made in #{year}"
  end

  def to_s
    'Hello I am car'
  end
end

class MyTruck < Vehicle
  include TruckHorn

  SIZE = 'Medium'
end

clio = MyCar.new(2006, 'Red', 'Clio')
puts clio.spray_paint('Blue')
puts clio.view_year
puts clio.gas_mileage(159, 400)
puts clio
puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors
clio.age
puts Vehicle.vehicle_number

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(rival)
    grade > rival.grade
  end

  protected

  attr_reader :grade
end

joe = Student.new(joe, 4)
bob = Student.new(bob, 5)
puts bob.better_grade_than?(joe)
