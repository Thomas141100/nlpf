import 'dart:io';
import 'package:flutter/material.dart';

class CreateJobOffer extends StatefulWidget {
  const CreateJobOffer({super.key});

  @override
  State<CreateJobOffer> createState() => _CreateJobOffer();
}

class _CreateJobOffer extends State<CreateJobOffer> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsController = TextEditingController();
  final companyNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    descriptionController.dispose();
    tagsController.dispose();
    companyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Creation d\'une offre d\'emploi',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'titre de l\'annconce',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: companyNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'nom de l\'entreprise',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(
                        minHeight: 200.0,
                        maxHeight: 400.0,
                      ),
                      child: Image.network(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'general informations',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                child: const Text(
                  'Post',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  //signup screen
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
