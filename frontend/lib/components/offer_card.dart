import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('An Offer Card'),
          subtitle: Text('This is an offer card'),
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
