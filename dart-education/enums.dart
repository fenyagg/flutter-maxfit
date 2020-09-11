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

  WorkOutLevel(this.value) {
    if (this.value == null) {
      throw FormatException('No WorkOutLevel value');
    }
  }

  WorkOutLevel.fromEnumString(String levelString) {
    var currentLevel =
        workoutLevelsMap.keys.where((levelKey) => levelKey.toString() == levelString);
    if (currentLevel.length > 0) {
      this.value = currentLevel.elementAt(0);
    } else {
      throw FormatException('No $levelString in EWorkoutLevel');
    }
  }

  String get title => workoutLevelsMap[this.value] ?? 'No title';
}

main() {
  var lvl = WorkOutLevel.fromEnumString(EWorkoutLevel.Beginner.toString());
  lvl.value = EWorkoutLevel.Advanced;
  print(lvl);
}
