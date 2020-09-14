import 'package:flutter/material.dart';
import 'package:flutter_app/components/save-button.dart';
import 'package:flutter_app/domain/workout-level.dart';
import 'package:flutter_app/domain/workout.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddWorkout extends StatefulWidget {
  final Workout workout;

  const AddWorkout({Key key, this.workout}) : super(key: key);

  @override
  _AddWorkoutState createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  final _fbKey = GlobalKey<FormBuilderState>();

  _saveWorkOut() async {
    if (_fbKey.currentState.saveAndValidate()) {
      return DatabaseService()
          .addOrUpdateWorkout(Workout.fromMap(_fbKey.currentState.value))
          .then((value) => Navigator.pop(context))
          .catchError((error) => print(error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add workout'),
        actions: <Widget>[
          SaveButton(
            onPressed: _saveWorkOut,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
        child: FormBuilder(
          key: _fbKey,
          autovalidate: true,
          initialValue: {
            'uid': widget.workout?.uid,
            'title': widget.workout?.title,
            'author': widget.workout?.author,
            'description': widget.workout?.description,
            'level': widget.workout?.level,
          },
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                  attribute: 'title',
                  decoration: InputDecoration(
                    labelText: "Title*",
                  ),
                  style: TextStyle(color: Colors.black),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(100),
                  ]),
              FormBuilderTextField(
                  attribute: 'author',
                  decoration: InputDecoration(
                    labelText: "Author*",
                  ),
                  style: TextStyle(color: Colors.black),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(100),
                  ]),
              FormBuilderTextField(
                  attribute: 'description',
                  minLines: 2,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                  style: TextStyle(color: Colors.black),
                  validators: [
                    FormBuilderValidators.maxLength(400),
                  ]),
              FormBuilderDropdown(
                attribute: 'level',
                items: workoutLevelsMap.keys
                    .where((element) => element != EWorkoutLevel.Any)
                    .map((workoutValue) => DropdownMenuItem(
                          value: workoutValue,
                          child: Text(
                            workoutLevelsMap[workoutValue],
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Level'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
