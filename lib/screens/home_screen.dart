import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/helpers/colors.dart';
import 'package:flutter_challenge/providers/todo_provider.dart';
import 'package:flutter_challenge/screens/add_edit_screen.dart';
import 'package:flutter_challenge/screens/widgets/default_text.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchText = TextEditingController();

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvder>(context);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.AppBarColor,
        title: DefaultText(
          text: 'TODO App',
          istile: true,
          color: AppColors.TextWhite,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.AppBarColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddEditScreen()));
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: AppColors.TextWhite,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            // search input
            child: TextFormField(
              autofocus: false,
              onChanged: (value) {
                setState(() {
                  searchText.text = value;
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(5),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Search',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: AppColors.AppBarColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          // list Items
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: provider.getTodoItems(searchText.text.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log("Data err");
                }
                if (snapshot.hasData) {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  List<QueryDocumentSnapshot> document = querySnapshot.docs;
                  // log("${document.length}");
                  if (document.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: document.length,
                      itemBuilder: (context, index) {
                        final item = document[index];

                        return Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.TextWhite,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  checkColor: AppColors.TextWhite,
                                  fillColor: MaterialStateProperty.all<Color>(
                                      AppColors.AppBarColor),
                                  activeColor: AppColors.Danger,
                                  value: item['isComplete'],
                                  onChanged: (value) =>
                                      provider.completeTask(item.id),
                                ),
                              ),
                              Expanded(
                                child: DefaultText(
                                  text: item['title'],
                                  fonstSize: 18,
                                  color: Colors.black,
                                  textDecoration: item['isComplete']
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              // button actions
                              buildActionBtn(item, provider),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: DefaultText(
                        text: "No have data!",
                        fonstSize: 30,
                        color: AppColors.Warning,
                      ),
                    );
                  }
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionBtn(
      QueryDocumentSnapshot<Object?> item, TodoProvder provder) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditScreen(
                    id: item.id,
                    oldTitle: item['title'],
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              size: 25,
              color: AppColors.Warning,
            )),
        IconButton(
          onPressed: () {
            buildAlertDialog(context: context, id: item.id, provder: provder);
          },
          icon: Icon(
            Icons.delete,
            size: 25,
            color: AppColors.Danger,
          ),
        ),
      ],
    );
  }
}

Future buildAlertDialog(
    {required BuildContext context,
    required id,
    required TodoProvder provder}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.warning,
              size: 40,
              color: AppColors.Danger,
            ),
          ),
          content: const DefaultText(
            text: "Do you want to delete this item?",
            fonstSize: 16,
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const DefaultText(
                text: 'Cancel',
                fonstSize: 16,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                provder.deleteItem(id);
              },
              child: DefaultText(
                text: 'OK',
                color: AppColors.TextWhite,
                fonstSize: 16,
              ),
            ),
          ],
        );
      });
}
