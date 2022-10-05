import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  const ConfirmationDialog(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: (() {
              Navigator.pop(context, 'Cancel');
            }),
            child: const Text('Cancel')),
        TextButton(
            onPressed: (() => Navigator.pop(context, 'OK')),
            child: const Text('Ok')),
      ],
    );
  }
}
