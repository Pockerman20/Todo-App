import 'package:flutter/material.dart';
import 'package:todo_app/Screens/add_page.dart';
import 'package:todo_app/services/todo_services.dart';
import 'package:todo_app/widget/todo_cart.dart';

import '../utils/snackbar_helper.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List items = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Todo Items',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  return TodoCart(
                    index: index,
                    item: item,
                    navigateEdit: navigateToEditPage,
                    deleteById: deleteById,
                  );
                },
              ),
            ),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text("Add Todo"),
      ),
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodo();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showMessage(context, msg: "Can't fetch data", error: true);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteById(String id) async {
    // Delete the item
    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
      showMessage(context, msg: "Todo Deleted", error: false);
    } else {
      showMessage(context, msg: "Error occured while deleting", error: true);
    }
  }
}
