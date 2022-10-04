import 'package:fht_linkedin/components/confirmation_dialog.dart';
import 'package:fht_linkedin/components/header.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: Header(
        key: const ValueKey('header'),
        title: 'FHT Linkedin - User',
        // displayLogout: false,
      ),
      body: Container(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/inesxaxelle.jpg',
                  height: 200,
                  width: 300,
                ),
                TextButton(
                  child: const Text(
                    'Upload Profile Picture',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                ),
              ],
            )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              width: 100,
                              child: const Text(
                                'Nom : ',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              width: 100,
                              child: const Text(
                                'Prenom : ',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              width: 100,
                              child: const Text(
                                'Mail : ',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.right,
                              ),
                            )
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: const Text(
                                'Boy',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: const Text(
                                'Boy',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: const Text(
                                'Boy',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),
                      /*Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Mail :',
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(3.0),
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: const Text(
                                'tottyboy@gmail.com',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),*/
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) => const ConfirmationDialog(
                                key:
                                    ValueKey('confirmation_dialog_user_delete'),
                                title: "Confirmation Dialog",
                                message:
                                    "Êtes vous sûr de vouloir supprimer cet utilisateur ?",
                              )));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
