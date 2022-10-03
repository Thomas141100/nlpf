import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class Client {
  static final Client _client = Client._internal();

  factory Client() {
    return _client;
  }

  Future<Response> signup(String mail, String name) async {
    Uri url = Uri.http('localhost:8080', '/signup');
    return http.post(
      url,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: jsonEncode({'mail': mail, 'name': name}),
    );
  }

  Future<Response> signin(String mail, String name) async {
    Uri url = Uri.http('localhost:8080', '/signin');
    return http.post(
      url,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: jsonEncode({'mail': mail, 'name': name}),
    );
  }

  Client._internal();
}
