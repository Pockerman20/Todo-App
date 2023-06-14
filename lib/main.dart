import 'package:flutter/material.dart';
import 'package:todo_app/Screens/launch_page.dart';

import 'Screens/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LaunchScreen(),
        '/todo': (context) => const TodoListPage(),
      },
    );
  }
}
