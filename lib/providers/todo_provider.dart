import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/helpers/database_helper.dart';

class TodoProvder extends ChangeNotifier {
  DatabaseHelper helper = DatabaseHelper();

  Future createTodo(BuildContext context, String title) async {
    await helper.createNewTodo(context, title);
    notifyListeners();
  }

  Future completeTask(id) async {
    await helper.completeTask(id);
    notifyListeners();
  }

  Future updateItem(id, String title) async {
    await helper.updateItem(id, title);
    notifyListeners();
  }

  Stream<QuerySnapshot> getTodos() {
    return helper.getTodos();
  }

  Future deleteItem(id) async {
    await helper.deleteItem(id);
    notifyListeners();
  }
}
