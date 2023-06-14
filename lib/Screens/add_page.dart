import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_services.dart';

import '../utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descrController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final descr = todo['description'];
      titleController.text = title;
      descrController.text = descr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Todo' : 'Add Todo',
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descrController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(isEdit ? 'Update' : 'Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateData() async {
    // Get the data from form
    final todo = widget.todo;
    if (todo == null) {
      print('you cannot call updated withour todo data');
      return;
    }
    final id = todo['_id'];
    // final isCompleted = todo['is_completed'];

    // Update data to the server
    final isSuccess = await TodoService.updateTodo(id, body);

    if (isSuccess) {
      showMessage(context, msg: "Update Success!", error: false);
      // print('Creation Success!');
    } else {
      showMessage(context, msg: "Update Failure!", error: true);
      // print(response.body);
    }
  }

  Future<void> submitData() async {
    // Get the data from form

    // Submit data to the server
    final isSuccess = await TodoService.addTodo(body);

    // show success or fail message based on status
    if (isSuccess) {
      titleController.text = '';
      descrController.text = '';
      showMessage(context, msg: "Creation Success!", error: false);
      // print('Creation Success!');
    } else {
      showMessage(context, msg: "Creation Failure!", error: true);
      // print(response.body);
    }
  }

  Map get body {
    final title = titleController.text;
    final descr = descrController.text;
    return {
      "title": title,
      "description": descr,
      "is_completed": false,
    };
  }
}
