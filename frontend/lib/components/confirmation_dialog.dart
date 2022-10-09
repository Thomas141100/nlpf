import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function()? confirmHandle;
  const ConfirmationDialog(
      {super.key,
      required this.title,
      required this.message,
      this.confirmHandle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: (() {
              Navigator.pop(context, 'Annuler');
            }),
            child: const Text('Cancel')),
        TextButton(
            onPressed: (() {
              if (confirmHandle != null) {
                confirmHandle!();
              }
              Navigator.pop(context, 'OK');
            }),
            child: const Text('Confirmer')),
      ],
    );
  }
}
