import 'package:flutter_app/domain/workout-level.dart';

class Workout {
  String uid;
  String title;
  String author;
  String description;
  EWorkoutLevel level;

  Workout({this.title, this.author, this.description, this.level});

  Workout.fromMap({uid: String, Map<String, dynamic> workoutMap})
      : uid = uid,
        title = workoutMap['title'],
        level = WorkOutLevel.fromEnumString(workoutMap['level']).value,
        description = workoutMap['description'],
        author = workoutMap['author'];

  Map<String, dynamic> toMap() =>
      {"title": title, "author": author, "description": description, "level": level.toString()};
}
