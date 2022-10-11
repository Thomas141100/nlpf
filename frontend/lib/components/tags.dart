import 'package:flutter/material.dart';

class Tags extends StatefulWidget {
  TextEditingController textController;

  Tags({super.key = const ValueKey("tags"), required this.textController});

  @override
  State<Tags> createState() => _Tags();
}

class _Tags extends State<Tags> {
  List<String> _tags = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: widget.textController,
            onSubmitted: (value) {
              _tags.add(value);
              setState(() {
                _tags = _tags;
              });
              widget.textController.clear();
            },
            cursorColor:Theme.of(context).primaryColor,
            decoration: InputDecoration(
                labelText: "Tags",
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color:Theme.of(context).primaryColor),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                icon:
                    Icon(Icons.tag, color: Theme.of(context).primaryColor)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Wrap(
              children: _tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        onDeleted: () {
                          setState(() {
                            _tags.remove(tag);
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
