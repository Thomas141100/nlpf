import 'package:fht_linkedin/module/client.dart';
import 'package:fht_linkedin/utils/utils.dart';
import 'package:flutter/material.dart';

import '../components/create_job_offer.dart';

class JobOfferCreationAlert extends AlertDialog {
  final _jobOfferformKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsController = TextEditingController();
  final companyNameController = TextEditingController();

  JobOfferCreationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: CreateJobOffer(
        titleController: titleController,
        descriptionController: descriptionController,
        tagsController: tagsController,
        companyNameController: companyNameController,
        formKey: _jobOfferformKey,
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
          onPressed: () {
            titleController.clear();
            descriptionController.clear();
            tagsController.clear();
            companyNameController.clear();
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),

        // The "Yes" button
        TextButton(
          onPressed: () async {
            if (_jobOfferformKey.currentState!.validate()) {
              // Client
              var response = await Client.sendJobOffer(
                titleController.text,
                descriptionController.text,
                tagsController.text,
                companyNameController.text,
              );
              if (response.statusCode == 200) {
                Navigator.of(context).pop();
                showSnackBar(context, "JobOffer Created");
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text("JobOffer Creation Failed"),
                    );
                  },
                );
              }
            }

            titleController.clear();
            descriptionController.clear();
            tagsController.clear();
            companyNameController.clear();
          },
          child: const Text('Post'),
        ),
      ],
    );
  }
}
