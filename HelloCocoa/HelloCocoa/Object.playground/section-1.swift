class Vehicle {
    
    {
        return "A \(self.color) vehicle"
    }
    {
        
        
}

//inheritance

class Car: Vehicle {
            override func description() -> String {
        var description = super.description()
        return description + " which is a car!"
            }
}

var redVehicle = Vehicle()
redVehicle.color = "Red"
redVehicle.maxSpeed = 90
redVehicle.travel()
redVehicle.description()

var mycar = Car()
mycar.maxSpeed = 100
mycar.travel()

mycar.description()
