import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/active-workouts.dart';
import 'package:flutter_app/components/workouts-list.dart';
import 'package:flutter_app/screens/add-workout.dart';
import 'package:flutter_app/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('MaxFit // ' + (_sectionIndex == 0 ? 'Active Workouts' : 'Find Workouts')),
        leading: Icon(Icons.fitness_center),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                AuthService().logout();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: SizedBox.shrink())
        ],
      ),
      body: _sectionIndex == 0 ? ActiveWorkouts() : WorkoutsList(),
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[Icon(Icons.fitness_center), Icon(Icons.search)],
        index: 0,
        height: 50,
        color: Colors.white.withOpacity(0.5),
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.5),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (int tapTargetIndex) => setState(() => _sectionIndex = tapTargetIndex),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => AddWorkout()));
        },
      ),
      /* bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            title: Text('Ny Workouts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Find Workouts'),
          ),
        ],
        backgroundColor: Colors.white54,
        currentIndex: _sectionIndex,
        selectedItemColor: Colors.black,
        onTap: (int tapTargetIndex) {
          setState(() {
            _sectionIndex = tapTargetIndex;
          });
        },
      ),*/
    );
  }
}
