import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shreya_task_app/components/appbar.dart';
import 'package:shreya_task_app/services/crud.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late FocusNode focus;
  TextEditingController taskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    focus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    bool status = false;
    bool epmtyValidation = false;
    return SafeArea(
      child: Scaffold(
        appBar: const ApplicationBar(
          appBarTitle: "Create New Task",
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 25, bottom: 15, right: 15, left: 15),
            child: Column(
              children: <Widget>[
                TextFormField(
                  focusNode: focus,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The empty task cannot be created';
                    }
                    return null;
                  },
                  style: const TextStyle(fontSize: 18.0, color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Enter task",
                      filled: true,
                      fillColor: Color.fromARGB(114, 181, 198, 253),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      )),
                  controller: taskController,
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                    color: const Color.fromARGB(255, 138, 127, 254),
                    textColor: Colors.white,
                    onPressed: (() async {
                      focus.unfocus();
                      if (_formKey.currentState!.validate()) {
                        var response = await CRUD.addTasks(
                            task: taskController.text, status: status);
                        if (response.errorStatus == 200) {
                          taskController.clear();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(response.message.toString()),
                                );
                              });
                        }
                      }
                    }),
                    child: const Text(
                      "Add Task",
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
