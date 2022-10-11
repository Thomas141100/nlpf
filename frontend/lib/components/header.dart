import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/main.dart';
import 'package:fht_linkedin/utils/utils.dart';
import 'package:flutter/material.dart';
import '../module/client.dart';

class Header extends StatefulWidget with PreferredSizeWidget {
  bool isCompany = false;
  String title;

  Header(
      {super.key = const ValueKey("header"),
      this.title = "",
      required this.isCompany});

  @override
  State<Header> createState() => _Header();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Header extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Traverser la rue !${widget.title.isNotEmpty ? " - ${widget.title}" : ""}",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(Icons.archive_outlined),
                tooltip: widget.isCompany
                    ? "Offres de l'entreprise"
                    : "Vos Candidatures",
                onPressed: () {
                  AutoRouter.of(context).pushNamed("/joboffers");
                },
              )),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(Icons.person),
                tooltip: 'Paramètres du compte',
                onPressed: () {
                  AutoRouter.of(context).pushNamed("/user");
                },
              )),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Déconnexion',
                onPressed: () {
                  MyApp.of(context).authService.authenticated = false;
                  Client.removeToken();
                  showSnackBar(context, "Utilisateur déconnecté");
                  AutoRouter.of(context)
                      .removeUntil((route) => route.name == "LoginRoute");
                },
              )),
        ],
      ),
    );
  }
}
