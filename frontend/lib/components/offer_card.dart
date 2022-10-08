import 'package:flutter/material.dart';

class OfferCard extends Card {
  final String title;
  final String description;
  final String companyName;
  final void Function() onTapHandle;
  final TextButton firstButton;
  final TextButton secondButton;

  const OfferCard(
      {super.key,
      required this.title,
      required this.description,
      required this.companyName,
      required this.onTapHandle,
      required this.firstButton,
      required this.secondButton});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(40),
        onTap: onTapHandle,
        child: SizedBox(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.album),
            title: Text(title),
            subtitle: Text(companyName),
            mouseCursor: MouseCursor.uncontrolled,
          ),
          Container(
            alignment: AlignmentDirectional.topStart,
            padding: const EdgeInsets.all(8),
            child: Text(
              description,
              softWrap: false,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              firstButton,
              const SizedBox(width: 8),
              secondButton,
              const SizedBox(width: 8),
            ],
          )
        ])),
      ),
    );
  }
}
