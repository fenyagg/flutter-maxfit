class Vehicle  with SpaceSheep {
  final String manufacturing;
  final double fuelCapacity;
  double fuelRemaining;

  static const double pi = 3.14;

  void showInfo() => isInSpace ?? print('$manufacturing: $fuelRemaining of $fuelCapacity critical: $criticalFuelLvl');

  double get criticalFuelLvl => fuelCapacity * 0.1;

  set newFuelRemaining(double val) => fuelRemaining = val;

  // default constructor
  Vehicle({this.manufacturing, this.fuelCapacity, this.fuelRemaining});
  
  // named constructor
  Vehicle.fromMap(Map<String, String> map)
  : this.manufacturing = map['manufacturing'],
    this.fuelCapacity = double.parse(map['fuelCapacity']),
    this.fuelRemaining = double.parse(map['fuelRemaining']);

  factory Vehicle.build(bool isBMW) {
    return isBMW ? Vehicle(manufacturing: "BMW", fuelCapacity: 60, fuelRemaining: 30) : Vehicle(manufacturing: "NOT_BMW", fuelCapacity: 60, fuelRemaining: 30);
  }
}

class Car extends Vehicle {
  final int _seats;

  Car(this._seats) : super.fromMap({"manufacturing": "LADA"});
}

void main () {
  print(Vehicle.pi);
  var machine = new Vehicle(manufacturing: "BMW", fuelCapacity: 60, fuelRemaining: 30)
    ..showInfo()
    ..showWhereIAm();

  var vechicle2 = new Vehicle.build(false)
    ..showInfo();

  // print(machine.manufacturing);
}

mixin SpaceSheep {
  bool isInSpace = true;
  void showWhereIAm() => print('I am in space');
}