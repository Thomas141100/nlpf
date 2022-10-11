import 'package:fht_linkedin/models/mcq.dart';
import 'package:fht_linkedin/module/client.dart';
import 'package:flutter/material.dart';
import 'package:fht_linkedin/module/validators.dart';

import '../mcq/upload_check_mcq.dart';
import '../models/candidacy.dart';

class JobOfferForm extends StatefulWidget {
  final String formTitle;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController tagsController;
  final TextEditingController companyNameController;
  final GlobalKey<FormState> formKey;
  final bool enableInput;
  final MCQ? mcq;
  final String offerId;

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
    required this.offerId,
  });

  @override
  State<JobOfferForm> createState() => _JobOfferForm();
}

class _JobOfferForm extends State<JobOfferForm> {
  List<String> _tags = [];
  List<JobOfferCandidacy> candidacies = [];

  @override
  void initState() {
    super.initState();
    if (widget.offerId.isNotEmpty) {
      Client.getJobOfferCandidacy(widget.offerId).then((value) {
        setState(() {
          candidacies = value;
        });
      });
    }
  }

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
              style: Theme.of(context).textTheme.titleLarge,
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
                          enabled: widget.enableInput),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                          controller: widget.tagsController,
                          onFieldSubmitted: (value) {
                            _tags.add(value);
                            setState(() {
                              _tags = _tags;
                            });
                            widget.tagsController.clear();
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tags',
                          ),
                          enabled: widget.enableInput),
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
                child: Check(
                    mcq: widget.mcq,
                    enableInput: widget.enableInput,
                    offerId: widget.offerId),
              ),
              candidacies.isNotEmpty
                  ? Column(
                      children: <Widget>[
                        const Center(
                          child: Text(
                            'Candidats',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(columns: const [
                            DataColumn(
                                label: Text('Nom',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Prenom',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Email',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            DataColumn(
                                label: Text('Score',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                          ], rows: [
                            ...candidacies.map(
                              (candidacy) {
                                return DataRow(cells: [
                                  DataCell(
                                    Text(candidacy.candidate.lastname),
                                  ),
                                  DataCell(
                                    Text(candidacy.candidate.firstname),
                                  ),
                                  DataCell(
                                    Text(candidacy.candidate.email),
                                  ),
                                  DataCell(
                                    Text(candidacy.score == 0 &&
                                            widget.mcq != null
                                        ? "Non évalué"
                                        : candidacy.score.toString()),
                                  ),
                                ]);
                              },
                            ),
                          ]),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}
