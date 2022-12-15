import 'package:flutter/material.dart';
import 'package:shreya_task_app/components/appbar.dart';
import 'package:intl/intl.dart';
import 'package:shreya_task_app/services/crud.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late FocusNode focusTask;
  late FocusNode focusDate;
  TextEditingController taskController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    focusTask = FocusNode();
    focusDate = FocusNode();
  }

  Future<DateTime>? pickDate(BuildContext context) async {
    DateTime? dueDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2024));
    return dueDate!;
  }

  @override
  Widget build(BuildContext context) {
    bool status = false;
    bool epmtyValidation = false;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const ApplicationBar(
          appBarTitle: "New Task",
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 20, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Create",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 115, 84, 118)),
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(198, 211, 201, 213),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: const Icon(Icons.edit),
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25, bottom: 15, right: 15, left: 15),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        focusNode: focusTask,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'The empty task cannot be created';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                        decoration: const InputDecoration(
                            hintText: "Enter task",
                            filled: true,
                            fillColor: Color.fromARGB(57, 229, 230, 230),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            )),
                        controller: taskController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                        maxLines: 5,
                        decoration: const InputDecoration(
                            hintText: "Write a note... ",
                            filled: true,
                            fillColor: Color.fromARGB(60, 188, 189, 189),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: dueDateController,
                        onTap: () async {
                          DateTime? dueDate = await pickDate(context);
                          setState(() {
                            // Format date
                            String formattedDueDate =
                                DateFormat('dd/MM/yyyy').format(dueDate!);
                            dueDateController.text =
                                formattedDueDate.toString();
                          });
                        },
                        focusNode: focusDate,
                        readOnly: true,
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_month),
                            hintText: "Due Date",
                            filled: true,
                            fillColor: Color.fromARGB(110, 216, 194, 212),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                          color: Color.fromARGB(255, 115, 84, 118),
                          textColor: Colors.white,
                          onPressed: (() async {
                            focusTask.unfocus();
                            focusDate.unfocus();
                            if (_formKey.currentState!.validate()) {
                              var response = await CRUD.addTasks(
                                  task: taskController.text, status: status);
                              if (response.errorStatus == 200) {
                                taskController.clear();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content:
                                            Text(response.message.toString()),
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
            ],
          ),
        ),
      ),
    );
  }
}
