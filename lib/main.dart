import 'package:shreya_task_app/screens/create_task.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print(Firebase.apps.length);
  await Firebase.initializeApp();

  runApp(const Welcome());
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: AddTask(),
    );
  }
}
