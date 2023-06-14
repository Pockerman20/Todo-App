import 'package:flutter/material.dart';

void showMessage(BuildContext context,
    {required String msg, required bool error}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: error ? Colors.white : Colors.black),
      ),
      backgroundColor: error ? Colors.red : Colors.white,
    ),
  );
}
