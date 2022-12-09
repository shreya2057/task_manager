import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shreya_task_app/model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection("Tasks");

class CRUD {
  static Future<Response> addTasks({String? task, bool? status}) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc();
    Map<String, dynamic> tasks = <String, dynamic>{
      "task_name": task,
      "task_status": status
    };

    var result = await documentReference.set(tasks).whenComplete(() {
      response.errorStatus = 200;
      response.message = "Task has been created successfully";
    }).catchError((e) {
      response.errorStatus = 500;
      response.message = "Error occured";
    });
    return response;
  }
}
