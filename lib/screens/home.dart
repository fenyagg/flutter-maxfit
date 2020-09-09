import 'package:flutter/material.dart';

import '../domain/workout.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('MaxFit'),
          leading: Icon(Icons.fitness_center),
        ),
        body: WorkoutsList());
  }
}

class WorkoutsList extends StatelessWidget {
  final workouts = <Workout>[
    Workout(
        title: 'Test 1',
        author: 'Max',
        description: 'First wt description',
        level: 'Beginner'),
    Workout(
        title: 'Test 2',
        author: 'Ivan',
        description: 'First wt description 2',
        level: 'Beginner+'),
    Workout(
        title: 'Test 3',
        author: 'Vadim',
        description: 'First wt description 3',
        level: 'Beginner++'),
    Workout(
        title: 'Test 4',
        author: 'Alexey',
        description: 'First wt description 4',
        level: 'Beginner+'),
    Workout(
        title: 'Test 5',
        author: 'Roma',
        description: 'First wt description 5',
        level: 'Beginner++'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(50, 65, 85, .9)),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.fitness_center,
                      color: Theme.of(context).textTheme.subtitle1.color,
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            right:
                                BorderSide(width: 1, color: Colors.white24))),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Theme.of(context).textTheme.subtitle1.color,
                  ),
                  title: Text(
                    workouts[i].title,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle1.color,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: subtitle(context, workouts[i]),
                ),
              ),
            );
          }),
    );
  }
}

Widget subtitle(BuildContext context, Workout workout) {
  var color = Colors.grey;
  double indicatorLevel = 0;

  switch (workout.level) {
    case "Beginner":
      color = Colors.green;
      indicatorLevel = 0.33;
      break;
    case "Beginner+":
      color = Colors.yellow;
      indicatorLevel = 0.66;
      break;
    case "Beginner++":
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }
  return Row(
    children: <Widget>[
      Expanded(
          flex: 1,
          child: LinearProgressIndicator(
            value: indicatorLevel,
            backgroundColor: Theme.of(context).textTheme.subtitle1.color,
            valueColor: AlwaysStoppedAnimation(color),
          )),
      SizedBox(width: 10),
      Expanded(
        flex: 3,
        child: Text(workout.level,
            style:
                TextStyle(color: Theme.of(context).textTheme.subtitle1.color)),
      )
    ],
  );
}
