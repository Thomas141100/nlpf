import 'package:flutter/material.dart';

class OfferCard extends Card {
  final String title;
  final String description;
  final String companyName;
  final void Function() onTapHandle;
  final TextButton firstButton;
  final TextButton? secondButton;
  final double cardHeight;

  const OfferCard(
      {super.key,
      required this.title,
      required this.description,
      required this.companyName,
      required this.onTapHandle,
      required this.firstButton,
      required this.cardHeight,
      this.secondButton});

  @override
  Widget build(BuildContext context) {
    List<Widget> btns = [firstButton];
    if (secondButton != null) {
      btns.add(const SizedBox(width: 8));
      btns.add(secondButton!);
      btns.add(const SizedBox(width: 8));
    }
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(40),
        onTap: onTapHandle,
        child: SizedBox(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.album),
<<<<<<< HEAD
            title: Text(title,  style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(companyName,  style: Theme.of(context).textTheme.titleSmall),
=======
            title: Text(title, style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(companyName,
                style: Theme.of(context).textTheme.titleSmall),
>>>>>>> 77ff87db27412fb651f89210e8458c53f49e4d45
            mouseCursor: MouseCursor.uncontrolled,
          ),
          Container(
            alignment: AlignmentDirectional.topStart,
            constraints: BoxConstraints(
              maxHeight: cardHeight,
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Flexible(
<<<<<<< HEAD
                  child: Text(
                    description,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
=======
                  child: Text(description,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium),
>>>>>>> 77ff87db27412fb651f89210e8458c53f49e4d45
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: btns,
          )
        ])),
      ),
    );
  }
}
