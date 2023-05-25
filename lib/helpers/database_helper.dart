import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

class DatabaseHelper {
  CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todos');

  // Create Unique item
  Future createNewTodo(BuildContext context, String title) async {
    bool unique = false;
    await FirebaseFirestore.instance
        .collection('todos')
        .where('title', isEqualTo: title)
        .get()
        .then((values) {
      for (var value in values.docs) {
        if (value['title'] == title) {
          unique = true;
        } else {
          unique = false;
        }
      }
    });
    if (unique == true) {
      Fluttertoast.showToast(
          msg: "data is duplicate", textColor: AppColors.Warning);
    } else {
      return await todoCollection.add(
        {
          'title': title,
          'isComplete': false,
        },
      );
    }
    log("$unique");
  }

  // Complete todo task
  Future completeTask(id) async {
    return await todoCollection.doc(id).update({"isComplete": true});
  }

  // Update todo Item
  Future updateItem(id, String title) async {
    bool unique = false;
    await FirebaseFirestore.instance
        .collection('todos')
        .where('title', isEqualTo: title)
        .get()
        .then((values) {
      for (var value in values.docs) {
        if (value['title'] == title) {
          unique = true;
        } else {
          unique = false;
        }
      }
    });

    if (unique == true) {
      Fluttertoast.showToast(
          msg: "data is duplicate", textColor: AppColors.Warning);
    } else {
      return await todoCollection
          .doc(id)
          .update({'title': title})
          .then((value) => log("Update Successful"))
          .catchError((err) => log("Update error with :$err"));
    }
  }

  // get all todo items
  Stream<QuerySnapshot> getTodos() {
    return todoCollection.orderBy('title', descending: true).snapshots();
  }

  // Delete todo item
  Future deleteItem(id) async {
    return await todoCollection
        .doc(id)
        .delete()
        .then((value) => log("Delete Successful"))
        .catchError(
          (err) => log("Failed to delete with:$err"),
        );
  }
}
