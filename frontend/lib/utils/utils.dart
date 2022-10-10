import 'package:fht_linkedin/models/candidacy.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {bool isError = false}) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 1500),
    content: Text(message),
    backgroundColor: isError ? Colors.red : Colors.green,
    behavior: SnackBarBehavior.floating,
    width: 350,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
