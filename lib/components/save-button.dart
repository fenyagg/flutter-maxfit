import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function onPressed;
  final bool disabled;

  SaveButton({Key key, @required this.onPressed, this.disabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onPressed();
      },
      color: Theme.of(context).primaryColor,
      child: Icon(
        Icons.save,
        color: this.disabled ? Colors.white.withOpacity(.5) : Colors.white,
      ),
    );
  }
}
