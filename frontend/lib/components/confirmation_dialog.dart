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
      /*
      color:
      IconColor:
      textStyle
      //Text()
      */
      title: Text(title,  style: Theme.of(context).textTheme.titleMedium),
      content: Text(message,  style: Theme.of(context).textTheme.bodyMedium),
      actions: <Widget>[
        TextButton(
            onPressed: (() {
              Navigator.pop(context, 'Annuler');
            }),
            child:  Text('Annuler, ', style: Theme.of(context).textTheme.labelMedium)),
        TextButton(
            onPressed: (() {
              if (confirmHandle != null) {
                confirmHandle!();
              }
              Navigator.pop(context, 'OK');
            }),
            child:  Text('Confirmer', style: Theme.of(context).textTheme.labelMedium),),
      ],
    );
  }
}
