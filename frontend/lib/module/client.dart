import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            'isCompany': company == '' ? 'false' : 'true',
            'company': company,
          }));
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> signin(String mail, String password) async {
    Uri url = Uri.http(_url, '/auth/login');
    try {
      var response = await http.post(
        url,
        headers: {
          "content-type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{'mail': mail, 'password': password}),
      );
      await saveToken(response);
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
        },
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> sendJobOffer(
      String title, String description, String tags, String companyname) async {
    Uri url = Uri.http(_url, '/joboffers');
    var token = await getToken();
    try {
      var response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $token",
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'employers': companyname,
          'description': description,
          'tags': tags
        }),
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<bool> saveToken(Response response) async {
    log(response.body);

    final prefs = await SharedPreferences.getInstance();
    var token = jsonDecode(response.body)['token'];
    var result = await prefs.setString("token", token);
    return result;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Client._internal();
}
