import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // reference our box
  final _mybox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitaData() {
    toDoList = [
      ["幹", false],
      ["你", false],
      ["娘", false],
      ['Look three small', false],
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _mybox.get('TODOLIST');
  }

  // update the database
  void updateDatabase() {
    _mybox.put('TODOLIST', toDoList);
  }
}
