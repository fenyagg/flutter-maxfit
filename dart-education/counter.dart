import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class _CounterState extends State<Counter> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        padding: EdgeInsets.symmetric(
          vertical: 60.0,
          horizontal: 20.0,
        ),
        child: Text('$counter'),
        color: Colors.cyan,
        onPressed: () {
          setState(() {
            ++counter;
          });
        },
      )
    );
  }
}

/*
* Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.cyan,
          ),
          width: 80,
          child: Center(
            child: Text(
              '$counter',
              style: TextStyle(fontSize: 30.0, color: Colors.black45),
            ),
          ),
        ),
* */

class Counter extends StatefulWidget {
  // Изменяемое состояние хранится не в виджете, а внутри объекта особого класса,
  // создаваемого методом createState()
  @override
  State<Counter> createState() => _CounterState();
// Результатом функции является не просто объект класса State,
// а обязательно State<ИмяНашегоВиджета>
}