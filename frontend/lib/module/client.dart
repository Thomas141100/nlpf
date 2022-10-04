import 'dart:developer';
import 'package:fht_linkedin/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';

class Client {
  static const String _url = "localhost:42069";

  static Future<Response> signup(
      String mail, String password, String company) async {
    Uri url = Uri.http(_url, '/auth/signup');
    try {
      return await post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'mail': mail,
            'password': password,
            'company': company,
          }));
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> signin(String mail, String password) async {
    Uri url = Uri.http(_url, '/auth/signin');
    try {
      var response = await http.post(
        url,
        headers: {
          "content-type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{'mail': mail, 'password': password}),
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> getUser(String mail, String id) async {
    Uri url = Uri.http(_url, '/users/$id');
    try {
      var response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": await storage.read(key: "token") ?? "",
        },
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  static void getToken(Response response) {
    log(response.body);
    storage.write(key: "token", value: response.headers['authorization']);
  }

  Client._internal();
}
