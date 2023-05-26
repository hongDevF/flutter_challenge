// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_challenge/helpers/colors.dart';
import 'package:flutter_challenge/helpers/validates.dart';
import 'package:flutter_challenge/providers/todo_provider.dart';
import 'package:flutter_challenge/screens/widgets/custom_textfield.dart';
import 'package:flutter_challenge/screens/widgets/default_text.dart';
import 'package:provider/provider.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({super.key, this.id, this.oldTitle});
  final id;
  final String? oldTitle;
  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  TextEditingController title = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvder>(context);
    title.text = widget.oldTitle ?? title.text;

    void onSave() {
      if (_key.currentState!.validate()) {
        if (widget.id == null) {
          provider.createTodo(title.text.trim());
        }
        if (widget.id != null) {
          provider.updateItem(widget.id, title.text.trim());
        }
        Navigator.pop(context);
      }
    }

    return Form(
      key: _key,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.AppBarColor,
          title: DefaultText(
            text: widget.id != null ? 'Update' : 'Create New Task',
            color: AppColors.TextWhite,
            istile: true,
            fonstSize: 20,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              customTextField(
                  hintText: 'title',
                  controller: title,
                  validator: (value) => Validates.emptyValidate(value),
                  onSubmit: (value) => onSave()),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => onSave(),
                      child: DefaultText(
                        text: widget.id != null ? ' Update' : 'Create',
                        color: AppColors.TextWhite,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
