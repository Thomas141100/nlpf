import 'package:fht_linkedin/utils/utils.dart';

import 'components/header.dart';
import 'package:flutter/material.dart';
import 'components/createJobOffer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _jobOfferformKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsController = TextEditingController();
  final companyNameController = TextEditingController();
  String? _token;

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: Header(title: 'Home'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "TOTO",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
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
                    style:
                        TextButton.styleFrom(foregroundColor: Colors.redAccent),
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
                        Navigator.of(context).pop();
                        showSnackBar(context, "Post Created");

                        // Client
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
            },
          );
        },
        tooltip: 'Post a JobOffer',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
