import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  DateTime time = DateTime.now();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 15), () {
      Navigator.pushNamedAndRemoveUntil(context, '/todo', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var len = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 85, 85, 85),
              Color.fromARGB(255, 156, 156, 156),
              Color.fromARGB(255, 119, 119, 119),
              Color.fromARGB(255, 236, 233, 233),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/512/2490/2490402.png",
                height: len,
                width: len,
              ),
            ),
            Text(
              "Random Text : $time",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
