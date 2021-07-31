import 'package:flutter/material.dart';
import 'data.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier{
  List<Task> _tasks = [

  ];
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount{
    return _tasks.length;
  }
  void addTask(String newTaskTitle, String dropdownValue,String time,bool status,int repeat) {
    final task = Task(name: newTaskTitle,desp: dropdownValue,time: time,status:status,repeat: repeat);
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(Task task){
    _tasks.remove(task);
    notifyListeners();
  }

}
