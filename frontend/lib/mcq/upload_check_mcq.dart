import 'package:fht_linkedin/mcq/form.dart';
import 'package:fht_linkedin/mcq/manage_csv.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../components/header.dart';
import 'dart:convert';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _Check();
}

class _Check extends State<Check> {
  bool importedCSV = false;
  ManageCSV mcq = ManageCSV();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        key: const ValueKey('header'),
        title: 'FHT Linkedin - Quizz',
        // displayLogout: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: importCSV,
              child:  Text("Choisir un fichier",  style: Theme.of(context).textTheme.labelMedium),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: importedCSV
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MCQForm(
                              mcqID: mcq.mcqID,
                              maxScore: mcq.maxScore,
                              questions: mcq.questions),
                        ),
                      );
                    }
                  : null,
              child: const Text(
                "Test",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
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
        importedCSV = mcq.parseCsv(csvString);
      });
    }
  }
}
