import 'package:flutter/material.dart';
import 'package:shreya_task_app/services/crud.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    bool status = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add task"),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              controller: taskController,
            ),
            TextButton(
                onPressed: (() async {
                  var response = await CRUD.addTasks(
                      task: taskController.text, status: status);
                }),
                child: Text("Check"))
          ],
        ),
      ),
    );
  }
}
