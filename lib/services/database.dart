import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/domain/workout-level.dart';
import 'package:flutter_app/domain/workout.dart';

class DatabaseService {
  final CollectionReference _workoutCollection = FirebaseFirestore.instance.collection('workouts');

  Future addOrUpdateWorkout(Workout workout) =>
      _workoutCollection.doc(workout.uid).set(workout.toMap());

  Stream<List<Workout>> getWorkouts({EWorkoutLevel level, String author}) {
    Query query = _workoutCollection;
    if (author != null) {
      query = _workoutCollection.where('author', isEqualTo: author);
    }

    if (level != null) {
      query = query.where('level', isEqualTo: level.toString());
    }

    return query.snapshots().map((QuerySnapshot data) => data.docs.map((DocumentSnapshot doc) {
          return Workout.fromMap(uid: doc.id, workoutMap: doc.data());
        }).toList());
  }
}
