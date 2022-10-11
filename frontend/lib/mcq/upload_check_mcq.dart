import 'package:fht_linkedin/mcq/form.dart';
import 'package:fht_linkedin/mcq/manage_csv.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../components/header.dart';
import 'dart:html' as html;
import 'dart:convert';

import '../models/mcq.dart';
import '../utils/utils.dart';

class Check extends StatefulWidget {
  final MCQ? mcq;
  final bool enableInput;
  const Check({super.key, required this.mcq, required this.enableInput});

  @override
  State<Check> createState() => _Check();
}

class _Check extends State<Check> {
  bool importedCSV = false;
  ManageCSV manageCSV = ManageCSV();

  @override
  Widget build(BuildContext context) {

    if (widget.mcq?.questions.isNotEmpty ?? false) {
      importedCSV = true;
      manageCSV.mcqID = "0";
      manageCSV.maxScore = widget.mcq!.maxScore;
      manageCSV.questions = widget.mcq!.questions;
    }

    if (widget.enableInput) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              onPressed: downloadFile,
              child: const Text("Télécharger le template CSV"),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
              onPressed: importCSV,
              child:  Text("Choisir un fichier",  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: importedCSV
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: MCQForm(
                                    mcqID: manageCSV.mcqID,
                                    maxScore: manageCSV.maxScore,
                                    questions: manageCSV.questions),
                              );
                            },
                          );
                        }
                      : null,
                  child: Text(
                    importedCSV
                        ? "Tester le QCM"
                        : "Veuillez importer un fichier CSV",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            onPressed: importedCSV
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: MCQForm(
                              mcqID: manageCSV.mcqID,
                              maxScore: widget.mcq!.maxScore,
                              questions: widget.mcq!.questions.toList()),
                        );
                      },
                    );
                  }
                : null,
            child: Text(
              importedCSV ? "Tester le QCM" : "Aucun QCM n'a été importé",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void importCSV() async {
    //Pick file
    FilePickerResult? csvFile = await FilePicker.platform.pickFiles(
        allowedExtensions: ['csv'],
        type: FileType.custom,
        allowMultiple: false);
    if (csvFile != null) {
      //decode bytes back to utf8
      String csvString = utf8.decode(csvFile.files.single.bytes!);
      setState(() {
        importedCSV = manageCSV.parseCsv(csvString);
        widget.mcq?.maxScore = manageCSV.maxScore;
        widget.mcq?.expextedScore = manageCSV.expextedScore;
        widget.mcq?.questions = manageCSV.questions;
      });
    }
  }

  void downloadFile() {
    String url = "../assets/csv/template_quizz.csv";
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }
}
