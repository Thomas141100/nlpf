import 'package:flutter/material.dart';

class OfferCard extends Card {
  final String title;
  final String description;
  final String companyName;
  final void Function() onTapHandle;
  final TextButton? firstButton;
  final TextButton? secondButton;
  final double cardHeight;
  final Map<String, String>? stats;

  const OfferCard(
      {super.key,
      required this.title,
      required this.description,
      required this.companyName,
      required this.onTapHandle,
      this.firstButton,
      required this.cardHeight,
      this.secondButton,
      this.stats});

  @override
  Widget build(BuildContext context) {
    List<Widget> btns = [];
    if (firstButton != null) {
      btns.add(firstButton!);
    }
    if (secondButton != null) {
      if (firstButton != null) btns.add(const SizedBox(width: 8));
      btns.add(secondButton!);
    }
    return Card(
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: onTapHandle,
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListTile(
                    iconColor: Theme.of(context).secondaryHeaderColor,
                    selectedColor: Theme.of(context).hoverColor,
                    textColor: Theme.of(context).backgroundColor,
                    leading: const Icon(Icons.album),
                    title: Text(title,
                        style: Theme.of(context).textTheme.titleMedium),
                    subtitle: Text(companyName,
                        style: Theme.of(context).textTheme.titleSmall),
                    mouseCursor: MouseCursor.uncontrolled,
                  ),
                  Expanded(
                      child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration:
                              const BoxDecoration(), // It's useful to have a decoration here, do not remove it
                          padding: const EdgeInsets.all(8),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(description,
                                      overflow: TextOverflow.fade,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ],
                            )
                          ]))),
                  Column(
                    children: [
                      if (stats != null)
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (stats != null)
                                for (var stat in stats!.entries)
                                  Column(
                                    children: [
                                      Text(stat.key,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text(stat.value,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                            ],
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: btns,
                      )
                    ],
                  )
                ])),
      ),
    );
  }
}
