import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/components/confirmation_dialog.dart';
import 'package:fht_linkedin/components/header.dart';
import 'package:fht_linkedin/models/user.dart';
import 'package:fht_linkedin/module/client.dart';
import 'package:fht_linkedin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  XFile? image;

  User? _currentUser;
  final ImagePicker picker = ImagePicker();
  bool ismcqUp = false;

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool reRender = false;

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void setCurrentUser() async {
    User? user = await Client.getCurrentUser();
    user ??= {} as User;
    setState(() {
      _currentUser = user;
      if (user != null) {
        _firstnameController.text = user.firstname;
        _lastnameController.text = user.lastname;
        _emailController.text = user.email;
      }
    });
  }

  void updateRender() {
    setState(() {
      reRender = !reRender;
    });
  }

  bool informationsChanged() {
    if (_currentUser == null) return false;
    return _currentUser!.firstname != _firstnameController.text ||
        _currentUser!.lastname != _lastnameController.text ||
        _currentUser!.email != _emailController.text;
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Selectionner un fichier multimedia'),
            content: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        Text('Depuis la galerie de photos'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('Prendre une photo'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (_currentUser == null) {
      setCurrentUser();
    }

    return Scaffold(
      appBar: Header(
        key: const ValueKey('header'),
        title: 'FHT Linkedin - User',
        // displayLogout: false,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //if image not null show the image
                  //if image null show text
                  image != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              //to show image, you type like this.
                              image!.path,
                              fit: BoxFit.cover,
                              width: 300,
                              height: 300,
                            ),
                          ))
                      : Column(children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(67, 96, 125, 139),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                                child: Text(
                              "Aucune photo de profil",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )),
                          ),
                        ]),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                        onPressed: () {
                          myAlert();
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.upload_file),
                            Text(
                              'Choisir un fichier',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: 250,
                              child: TextFormField(
                                onChanged: (_) => updateRender(),
                                controller: _firstnameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Prénom"),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: 250,
                              child: TextFormField(
                                onChanged: (_) => updateRender(),
                                controller: _lastnameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nom'),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: 250,
                              child: TextFormField(
                                onChanged: (_) => updateRender(),
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email'),
                              ),
                            )),
                      ]),
                  SizedBox(
                    width: 200,
                    child: Column(children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: informationsChanged()
                              ? const Color.fromARGB(255, 10, 129, 12)
                              : Colors.grey,
                        ),
                        onPressed: informationsChanged()
                            ? () async {
                                try {
                                  var response = await Client.updateUser(User(
                                      _currentUser!.id,
                                      _firstnameController.text,
                                      _lastnameController.text,
                                      _emailController.text,
                                      _currentUser!.isCompany,
                                      _currentUser!.companyName));
                                  if (response.statusCode != 200) {
                                    throw ErrorDescription(
                                        "Failed to update user");
                                  }
                                  showSnackBar(
                                      context, "Votre profil a été mis à jour");
                                  setCurrentUser();
                                } catch (e) {
                                  showSnackBar(
                                      context, "La mise à jour a échoué",
                                      isError: true);
                                }
                              }
                            : null,
                        child: Row(children: const [
                          Icon(Icons.save, color: Colors.white),
                          Text(
                            ' Valider le changement',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Row(children: const [
                          Icon(Icons.remove_circle, color: Colors.white),
                          Text(
                            ' Supprimer le compte',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: ((context) => ConfirmationDialog(
                                    key: const ValueKey(
                                        'confirmation_dialog_user_delete'),
                                    title: "Confirmation Dialog",
                                    message:
                                        "Êtes vous sûr de vouloir supprimer cet utilisateur ?",
                                    confirmHandle: _currentUser != null
                                        ? () async {
                                            var response =
                                                await Client.deleteUser(
                                                    _currentUser!.getId());
                                            if (response.statusCode == 200) {
                                              Client.removeToken();
                                              // ignore: use_build_context_synchronously
                                              AutoRouter.of(context)
                                                  .removeUntil((route) =>
                                                      route.name ==
                                                      "LoginRoute");
                                              // ignore: use_build_context_synchronously
                                              showSnackBar(context,
                                                  "Le compte a été supprimé");
                                            } else {
                                              showSnackBar(context,
                                                  "Une erreur est survenue",
                                                  isError: true);
                                            }
                                          }
                                        : null,
                                  )));
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(15.0),
                  width: 250,
                  child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nouveau mot de passe')),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  width: 250,
                  child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirmer le mot de passe')),
                ),
                SizedBox(
                  width: 200,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 10, 129, 12),
                    ),
                    onPressed: () {
                      showSnackBar(context, "Feature not yet implemented");
                    },
                    child: Row(children: const [
                      Icon(Icons.save, color: Colors.white),
                      Text(
                        'Valider le changement',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
