import 'package:flutter/material.dart';
import 'task_data.dart';
import 'package:provider/provider.dart';
import 'package:schedule/create_list_tile.dart';

class TaskView extends StatefulWidget {

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return ListTilePage(
              title: task.name,
              subTitle: task.desp,
              time: task.time,
              status: task.status,
              count: taskData.taskCount,
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
