import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Test"),
      content: const Text("Dialog test"),
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
