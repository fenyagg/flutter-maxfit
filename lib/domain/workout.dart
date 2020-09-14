import 'package:flutter_app/domain/workout-level.dart';

class Workout {
  String uid;
  String title;
  String author;
  String description;
  EWorkoutLevel level;

  Workout({this.uid, this.title, this.author, this.description, this.level});

  Workout.fromJson({uid: String, Map<String, dynamic> workoutMap})
      : uid = uid,
        title = workoutMap['title'],
        // convert lvl to enum
        level = WorkOutLevel.fromEnumString(workoutMap['level']).value,
        description = workoutMap['description'],
        author = workoutMap['author'];

  Workout.fromMap(Map<String, dynamic> workout)
      : uid = workout['uid'],
        title = workout['title'],
        author = workout['author'],
        description = workout['description'],
        level = workout['level'];

  Map<String, dynamic> toMap() =>
      {"title": title, "author": author, "description": description, "level": level.toString()};
}
