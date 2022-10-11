import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/main.dart';
import 'package:fht_linkedin/utils/utils.dart';
import 'package:flutter/material.dart';
import '../module/client.dart';

class Header extends StatefulWidget with PreferredSizeWidget {
  var displayLogout = true;
  var displayProfile = true;
  String title;

  Header(
      {super.key = const ValueKey("header"),
      this.title = "",
      this.displayLogout = true,
      this.displayProfile = true});

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
<<<<<<< HEAD
            "Traverser la rue !${widget.title.isNotEmpty ? " - ${widget.title}" : ""}",  style: Theme.of(context).textTheme.headlineLarge, ),
=======
          "Traverser la rue !${widget.title.isNotEmpty ? " - ${widget.title}" : ""}",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
>>>>>>> 77ff87db27412fb651f89210e8458c53f49e4d45
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: widget.displayProfile
                ? IconButton(
                    icon: const Icon(Icons.person),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      AutoRouter.of(context).pushNamed("/user");
                    },
                  )
                : null,
          ),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: widget.displayLogout
                  ? IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        MyApp.of(context).authService.authenticated = false;
                        Client.removeToken();
                        showSnackBar(context, "Utilisateur déconnecté");
                        AutoRouter.of(context)
                            .removeUntil((route) => route.name == "LoginRoute");
                      },
                    )
                  : null),
        ],
      ),
    );
  }
}
