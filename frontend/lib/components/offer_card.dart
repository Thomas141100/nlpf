import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  var title = "";
  var description = "";
  var companyName = "";

  OfferCard(
      {super.key,
      required this.title,
      required this.description,
      required this.companyName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          leading: const Icon(Icons.album),
          title: Text(title),
          subtitle: Text(description),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: (() {}), child: const Text('Candidate')),
            const SizedBox(width: 8),
            TextButton(
              child: const Text('LISTEN'),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
          ],
        )
      ]),
    );
  }
}
