enum EWorkoutLevel {
  Any,
  Beginner,
  Intermediate,
  Advanced,
}

Map<EWorkoutLevel, String> workoutLevelsMap = {
  EWorkoutLevel.Any: "Any level",
  EWorkoutLevel.Beginner: "Beginner",
  EWorkoutLevel.Intermediate: "Intermediate",
  EWorkoutLevel.Advanced: "Advanced",
};

class WorkOutLevel {
  EWorkoutLevel value;

  WorkOutLevel(this.value);

  WorkOutLevel.fromEnumString(String levelString) {
    var currentLevel =
        workoutLevelsMap.keys.where((levelKey) => levelKey.toString() == levelString);
    if (currentLevel.length > 0) {
      this.value = currentLevel.elementAt(0);
    } else {
      throw FormatException('No string "$levelString" in EWorkoutLevel');
    }
  }

  @override
  String toString() => value.toString();

  String get title => workoutLevelsMap[this.value] ?? 'No title';
}
