import 'package:auto_route/auto_route.dart';
import 'package:fht_linkedin/utils/utils.dart';
import 'package:flutter/material.dart';
import '../module/client.dart';

class Header extends StatefulWidget with PreferredSizeWidget {
  var displayLogout = true;
  String title;

  Header(
      {super.key = const ValueKey("header"),
      this.title = "",
      this.displayLogout = true});

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
        title: Text(
            "FHT Linkedin${widget.title.isNotEmpty ? " - ${widget.title}" : ""}"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: widget.displayLogout
                  ? IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        Client.removeToken();
                        AutoRouter.of(context)
                            .removeUntil((route) => route.name == "LoginRoute");
                        showSnackBar(context, "User disconnected");
                      },
                    )
                  : null),
        ],
      ),
    );
  }
}
