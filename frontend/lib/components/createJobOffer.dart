import 'dart:io';
import 'package:flutter/material.dart';

class CreateJobOffer extends StatefulWidget {
  final titleController;
  final descriptionController;
  final tagsController;
  final companyNameController;
  final formKey;

  const CreateJobOffer(
      {this.titleController = TextEditingController,
      this.descriptionController = TextEditingController,
      this.tagsController = TextEditingController,
      this.companyNameController = TextEditingController,
      this.formKey = FormState,
      super.key});

  @override
  State<CreateJobOffer> createState() => _CreateJobOffer();
}

class _CreateJobOffer extends State<CreateJobOffer> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
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
                        controller: widget.titleController,
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
                        controller: widget.companyNameController,
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
              controller: widget.descriptionController,
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
        ],
      ),
    );
  }
}
