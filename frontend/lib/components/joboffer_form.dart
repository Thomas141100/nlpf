import 'package:fht_linkedin/models/mcq.dart';
import 'package:flutter/material.dart';
import 'package:fht_linkedin/module/validators.dart';

import '../mcq/upload_check_mcq.dart';

class JobOfferForm extends StatefulWidget {
  final String formTitle;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController tagsController;
  final TextEditingController companyNameController;
  final GlobalKey<FormState> formKey;
  final bool enableInput;
  final MCQ? mcq;

  const JobOfferForm({
    required this.formTitle,
    required this.titleController,
    required this.descriptionController,
    required this.tagsController,
    required this.companyNameController,
    required this.formKey,
    required this.mcq,
    this.enableInput = false,
    super.key,
  });

  @override
  State<JobOfferForm> createState() => _CreateJobOffer();
}

class _CreateJobOffer extends State<JobOfferForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.formTitle,
              style: const TextStyle(
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
                          labelText: 'Titre de l\'annonce',
                        ),
                        validator: Validators.generalValidator(),
                        enabled: widget.enableInput,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                          controller: widget.companyNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nom de l\'entreprise',
                          ),
                          validator: Validators.generalValidator(),
                          enabled: widget.enableInput),
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
                        minHeight: 150.0,
                        maxHeight: 300.0,
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
                  labelText: 'Description',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Renseignez ce champs';
                  }
                  return null;
                },
                enabled: widget.enableInput),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Check(mcq: widget.mcq, enableInput: widget.enableInput),
          ),
        ],
      ),
    );
  }
}
