import 'package:fht_linkedin/mcq/form.dart';
import 'package:fht_linkedin/mcq/manage_csv.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html' as html;
import 'dart:convert';

import '../models/mcq.dart';
import '../utils/utils.dart';

class Check extends StatefulWidget {
  final MCQ? mcq;
  final bool enableInput;
  final String offerId;
  const Check(
      {super.key,
      required this.mcq,
      required this.enableInput,
      required this.offerId});

  @override
  State<Check> createState() => _Check();
}

class _Check extends State<Check> {
  bool importedCSV = false;
  bool wronfCSVFormat = false;
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
                  child: const Text("Open file picker"),
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
                                    offerId: widget.offerId,
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
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              wronfCSVFormat
                  ? const Text(
                      "Format du CSV incorrect",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
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
                              offerId: widget.offerId,
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
        try {
          importedCSV = manageCSV.parseCsv(csvString);
          widget.mcq?.maxScore = manageCSV.maxScore;
          widget.mcq?.expectedScore = manageCSV.expectedScore;
          widget.mcq?.questions = manageCSV.questions;
          wronfCSVFormat = false;
        } catch (e) {
          showSnackBar(context, "Mauvais format de CSV", isError: true);
          wronfCSVFormat = true;
        }
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
