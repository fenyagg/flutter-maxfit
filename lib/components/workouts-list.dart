import 'package:flutter/material.dart';
import 'package:flutter_app/domain/appUser.dart';
import 'package:flutter_app/domain/workout-level.dart';
import 'package:flutter_app/domain/workout.dart';
import 'package:flutter_app/screens/add-workout.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

class WorkoutsList extends StatefulWidget {
  @override
  _WorkoutsListState createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> with TickerProviderStateMixin {
  List<Workout> workouts = [];
  DatabaseService db = DatabaseService();
  AppUser user;
  String _selectedWorkoutId;

  var filterOnlyMyWorkouts = false;
  var filterLevel = EWorkoutLevel.Any;

  var filterText = '';
  var filterHeight = 0.0;

  filter({bool clear = false}) {
    if (clear) {
      filterOnlyMyWorkouts = false;
      filterLevel = EWorkoutLevel.Any;
    }
    setState(() {
      filterText = filterOnlyMyWorkouts ? 'My Workouts' : 'All workouts';
      filterText += '/' + workoutLevelsMap[filterLevel];
      filterHeight = 0;
    });

    loadData();
  }

  loadData() async {
    var stream = db.getWorkouts(
      author: null,
      level: filterLevel != EWorkoutLevel.Any ? filterLevel : null,
    );
    stream.listen((List<Workout> data) {
      setState(() {
        workouts = data;
      });
    });
  }

  AnimationController _controller;
  Animation<Color> _animation;

  animate() {}

  @override
  void initState() {
    super.initState();
    filter(clear: true);

    _controller = AnimationController(vsync: this, duration: Duration());
    _animation = ColorTween(begin: Colors.black, end: Colors.white).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser>(context);

    var workoutsList = Expanded(
      child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, i) {
            return Card(
              color: _selectedWorkoutId == workouts[i].uid ? _animation?.value : Colors.black,
              elevation: 2.0,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                decoration: BoxDecoration(color: Color.fromRGBO(50, 65, 85, .9)),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  leading: Container(
                    height: 40,
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.fitness_center,
                      color: Theme.of(context).textTheme.subtitle1.color,
                    ),
                    decoration: BoxDecoration(
                        border: Border(right: BorderSide(width: 1, color: Colors.white24))),
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
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AddWorkout(
                                  workout: workouts[i],
                                )));
                    _selectedWorkoutId = workouts[i].uid;
                    _controller.duration = Duration(milliseconds: 0);
                    _controller.forward();

                    Future.delayed(const Duration(milliseconds: 250), () {
                      _controller.duration = Duration(milliseconds: 200);
                      _controller.reverse();
                    });
                  },
                ),
              ),
            );
          }),
    );

    var filterInfo = Container(
      margin: EdgeInsets.only(top: 3, left: 7, right: 7, bottom: 5),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
      height: 40,
      child: RaisedButton(
        child: Row(
          children: <Widget>[
            Icon(Icons.filter_list),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                filterText,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            filterHeight = (filterHeight == 0.0 ? 200.0 : 0.0);
          });
        },
      ),
    );

    var filterForm = AnimatedContainer(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SwitchListTile(
                  title: const Text(
                    'Only My Workouts',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: filterOnlyMyWorkouts,
                  onChanged: (bool val) => setState(() => filterOnlyMyWorkouts = val)),
              DropdownButtonFormField<EWorkoutLevel>(
                decoration: const InputDecoration(labelText: 'Level'),
                items: EWorkoutLevel.values
                    .map((workoutValue) => DropdownMenuItem(
                          value: workoutValue,
                          child: Text(
                            WorkOutLevel(workoutValue).title,
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                    .toList(),
                value: filterLevel,
                onChanged: (EWorkoutLevel val) => setState(() => filterLevel = val),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        filter();
                      },
                      child: Text("Apply", style: TextStyle(color: Colors.white)),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        filter(clear: true);
                      },
                      child: Text("Clear", style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: filterHeight,
    );

    return Column(
      children: [
        filterInfo,
        filterForm,
        workoutsList,
      ],
    );
  }
}

Widget subtitle(BuildContext context, Workout workout) {
  var color = Colors.grey;
  double indicatorLevel = 0;

  switch (workout.level) {
    case EWorkoutLevel.Beginner:
      color = Colors.green;
      indicatorLevel = 0.33;
      break;
    case EWorkoutLevel.Intermediate:
      color = Colors.yellow;
      indicatorLevel = 0.66;
      break;
    case EWorkoutLevel.Advanced:
      color = Colors.red;
      indicatorLevel = 1;
      break;
    default:
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
        child: Text(WorkOutLevel(workout.level).title,
            style: TextStyle(color: Theme.of(context).textTheme.subtitle1.color)),
      )
    ],
  );
}
