import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  String input;
  Icon icon;
  TextEditingController textController;

  CustomTextField(
      {super.key,
      this.input = "",
      this.icon = const Icon(Icons.search),
      required this.textController});

  @override
  State<CustomTextField> createState() => _CustomTextField();
}

class _CustomTextField extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: widget.textController,
        cursorColor:  Theme.of(context).primaryColor,//Text()
        decoration: InputDecoration(
            labelText: widget.input,
            labelStyle:  TextStyle(
                color: Theme.of(context).primaryColor, fontSize: 16),
            focusedBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),//Text()
            ),
            enabledBorder:  UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).primaryColor)),//Text()
            icon: widget.icon),
      ),
    );
  }
}
