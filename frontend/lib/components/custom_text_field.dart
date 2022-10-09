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
        cursorColor: const Color.fromARGB(255, 124, 62, 102),
        decoration: InputDecoration(
            labelText: widget.input,
            labelStyle: const TextStyle(
                color: Color.fromARGB(255, 124, 62, 102), fontSize: 16),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 124, 62, 102)),
            ),
            enabledBorder: const UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 124, 62, 102))),
            icon: widget.icon),
      ),
    );
  }
}
