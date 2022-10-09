import 'package:fht_linkedin/models/job_offer.dart';
import 'package:fht_linkedin/module/client.dart';
import 'package:fht_linkedin/utils/utils.dart';
import 'package:flutter/material.dart';

import '../components/joboffer_form.dart';
import '../models/mcq.dart';

class JobOfferDialog extends AlertDialog {
  final _jobOfferformKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsController = TextEditingController();
  final companyNameController = TextEditingController();
  final bool isEdditing;
  final bool isCreating;
  final JobOffer? jobOffer;
  final updateJobOffersList;

  JobOfferDialog(
      {super.key,
      this.isEdditing = false,
      this.isCreating = false,
      this.jobOffer,
      this.updateJobOffersList});

  void clearInputs() {
    titleController.clear();
    descriptionController.clear();
    tagsController.clear();
    companyNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    MCQ mcq = MCQ.empty();

    List<Widget>? actions = [];
    if (isEdditing || isCreating) {
      actions.add(TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
        onPressed: () {
          clearInputs();
          Navigator.of(context).pop();
        },
        child: const Text('Annuler'),
      ));
    }

    if (isCreating) {
      actions.add(TextButton(
        onPressed: () async {
          if (_jobOfferformKey.currentState!.validate()) {
            var response = await Client.sendJobOffer(
              titleController.text,
              descriptionController.text,
              tagsController.text,
              companyNameController.text,
              mcq,
            );
            if (response.statusCode == 200) {
              clearInputs();
              Navigator.of(context).pop();
              updateJobOffersList();
              showSnackBar(context, "L'offre a été créée");
            } else {
              showSnackBar(context, "La création de l'offre a échoué",
                  isError: true);
            }
          }
        },
        child: const Text('Créer'),
      ));
    } else if (isEdditing && jobOffer != null) {
      actions.add(TextButton(
        onPressed: () async {
          if (_jobOfferformKey.currentState!.validate()) {
            var response = await Client.updateJobOffer(
              jobOffer!.getId(),
              titleController.text,
              descriptionController.text,
              tagsController.text,
              companyNameController.text,
            );
            if (response.statusCode == 200) {
              clearInputs();
              Navigator.of(context).pop();
              updateJobOffersList();
              showSnackBar(context, "L'offre a été mise à jour");
            } else {
              showSnackBar(context, "La mise à jour de l'offre a échoué",
                  isError: true);
            }
          }
        },
        child: const Text('Enregistrer'),
      ));
    } else {
      actions.add(
        TextButton(
          onPressed: () {
            clearInputs();
            Navigator.of(context).pop();
          },
          child: const Text('Fermer'),
        ),
      );
    }

    if (!isCreating && jobOffer != null) {
      titleController.text = jobOffer!.title;
      companyNameController.text = jobOffer!.companyName;
      descriptionController.text = jobOffer!.description ?? "";
    }

    var formTitle = "";
    if (isCreating) {
      formTitle = "Création d'une offre d'emploi ";
    } else if (isEdditing) {
      formTitle = "Edition d'une offre d'emploi";
    } else {
      formTitle = "Offre d'emploi";
    }
    return AlertDialog(
      content: JobOfferForm(
        titleController: titleController,
        descriptionController: descriptionController,
        tagsController: tagsController,
        companyNameController: companyNameController,
        mcq: mcq,
        formKey: _jobOfferformKey,
        formTitle: formTitle,
        enableInput: isCreating || isEdditing,
      ),
      actions: actions,
    );
  }
}
