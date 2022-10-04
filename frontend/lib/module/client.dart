import 'package:fht_linkedin/models/user.dart';
import 'package:flutter/cupertino.dart';
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
      var response = await post(
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

  static Future<Response> getUser(String id) async {
    Uri url = Uri.http(_url, '/users/$id');
    try {
      var token = await getToken();
      var response = await get(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token"
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
    final prefs = await SharedPreferences.getInstance();
    var token = jsonDecode(response.body)['token'];
    var result = await prefs.setString("token", token);
    return result;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static String getJsonFromJWT(String token) {
    var splittedToken = token.split('.');
    if (splittedToken.length != 3) {
      throw ErrorDescription("JWT token is invalid to decode");
    }
    String normalizedSource = base64Url.normalize(splittedToken[1]);
    return utf8.decode(base64Url.decode(normalizedSource));
  }

  static Future<User?> getCurrentUser() async {
    var token = await getToken();
    var userId = jsonDecode(getJsonFromJWT(token!))['id'];
    var response = await getUser(userId);
    if (response.statusCode != 200 || response.body.isEmpty) {
      return null;
    }
    return jsonDecode(response.body);
  }

  Client._internal();
}
