import 'package:fht_linkedin/models/candidacy.dart';
import 'package:fht_linkedin/models/job_offer.dart';
import 'package:fht_linkedin/models/user.dart';
import 'package:fht_linkedin/utils/filters.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/mcq.dart';

class Client {
  static String _url = "localhost:42069";

  Future<String> _getApiUrl() async {
    final prefs = SharedPreferences.getInstance();
    return (await prefs).getString("apiUrl")!;
  }

  Client() {
    _getApiUrl().then((value) => _url = value);
  }

  static Future<Response> signup(User newUser, String password) async {
    Uri url = Uri.http(_url, '/api/auth/signup');
    try {
      return await post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'firstname': newUser.firstname,
            'lastname': newUser.lastname,
            'mail': newUser.email,
            'password': password,
            'isCompany': newUser.isCompany.toString(),
            'company': newUser.companyName ?? '',
          }));
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> signin(String mail, String password) async {
    Uri url = Uri.http(_url, '/api/auth/login');
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
    Uri url = Uri.http(_url, '/api/users/$id');
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

  static Future<Response> deleteUser(String id) async {
    Uri url = Uri.http(_url, '/api/users/$id');
    try {
      var token = await getToken();
      var response = await delete(
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

  static Future<Response> updateUser(User user, {String? password}) async {
    Uri url = Uri.http(_url, '/api/users/${user.id}');
    try {
      var token = await getToken();
      var userMap = user.toJson();
      if (password != null && password.isNotEmpty) {
        userMap.addAll({'password': password});
      }
      var response = await put(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(userMap),
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  /////////////////Functions relative to the candidacy part /////////

  static Future<List<UserCandidacy>> getCurrentUserAllCandidacies(
      String id) async {
    Uri url = Uri.http(_url, '/api/users/$id/candidacies');
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
      if (response.statusCode != 200) {
        throw ErrorDescription("status code is not 200");
      }
      var body = response.body;
      if (body.isEmpty) return List.empty();
      var decodedJson = jsonDecode(body);
      List<UserCandidacy> candidaciesList = [];
      for (var userCandidacy in decodedJson) {
        candidaciesList.add(UserCandidacy.fromJson(userCandidacy));
      }
      return candidaciesList;
    } catch (e) {
      throw ErrorDescription("Failed to fetch all offers. Code $e");
    }
  }

  /////////////////Functions relative to the jobOffer part /////////

  static Future<List<JobOffer>> getAllOffers({Filter? filters}) async {
    Uri url = Uri.http(_url, '/api/joboffers', filters?.parameters);
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
      if (response.statusCode != 200) {
        throw ErrorDescription("status code is not 200");
      }
      var body = response.body;
      if (body.isEmpty) return List.empty();
      List<dynamic> decodedJson = jsonDecode(body);
      List<JobOffer> jobOffers = List.empty(growable: true);
      for (Map<dynamic, dynamic> jobOfferJson in decodedJson) {
        jobOffers.add(JobOffer.fromJson(jobOfferJson));
      }
      return jobOffers;
    } catch (e) {
      throw ErrorDescription("Failed to fetch all offers. Code $e");
    }
  }

  static Future<JobOffer> gotJobOfferById(String id) async {
    Uri url = Uri.http(_url, '/api/joboffers/$id');
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
      var body = response.body;
      if (body.isEmpty) return JobOffer.empty();
      dynamic decodedJson = jsonDecode(body);
      JobOffer jobOffers = JobOffer.fromJson(decodedJson);
      return jobOffers;
    } catch (e) {
      throw ErrorDescription("Failed to fetch all offers. Code $e");
    }
  }

  static Future<Response> sendJobOffer(String title, String description,
      String tags, String companyname, MCQ mcq) async {
    Uri url = Uri.http(_url, '/api/joboffers');
    var token = await getToken();
    try {
      var response = await post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $token",
        },
        body: jsonEncode(
          {
            'title': title,
            'companyName': companyname,
            'description': description,
            'tags': tags,
            'mcq': {
              'maxScore': mcq.maxScore,
              'expectedScore': mcq.expectedScore,
              'questions': mcq.questions,
            },
          },
        ),
      );
      return response;
    } catch (e) {
      print(e);
      return Response("", 500);
    }
  }

  static Future<Response> updateJobOffer(String id, String title,
      String description, String tags, String companyname) async {
    Uri url = Uri.http(_url, '/api/joboffers/$id');
    var token = await getToken();
    try {
      var response = await put(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $token",
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'companyname': companyname,
          'description': description,
          'tags': tags
        }),
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> deleteJobOffer(String jobOfferId) async {
    Uri url = Uri.http(_url, '/api/joboffers/$jobOfferId');
    var token = await getToken();
    try {
      var response = await delete(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> addCandidacy2JobOffer(String id) async {
    Uri url = Uri.http(_url, '/api/joboffers/$id/candidacies');
    var token = await getToken();
    try {
      var response = await post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $token",
        },
        body: jsonEncode(<String, String>{}),
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  /////////////////Functions relative to the mcq/certification part /////////

  static Future<Response> postmcq(
      String id, List<Map<String, Object>> mcq) async {
    Uri url = Uri.http(_url, '/api/joboffers/$id');
    var token = await getToken();
    try {
      var response = await post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $token",
        },
        body: jsonEncode(mcq),
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> getmcq(
      String id, List<Map<String, Object>> mcq) async {
    Uri url = Uri.http(_url, '/api/joboffers/$id');
    var token = await getToken();
    try {
      var response = await get(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $token",
        },
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> saveMCQ(String id, int resultScore) async {
    Uri url = Uri.http(_url, '/api/joboffers/$id/mcq');
    var token = await getToken();
    try {
      var response = await post(
        url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer $token",
        },
        body: jsonEncode(<String, String>{
          'score': resultScore.toString(),
        }),
      );
      return response;
    } catch (e) {
      return Response("", 500);
    }
  }

  static Future<Response> getUsermcq(String id) async {
    Uri url = Uri.http(_url, '/api/joboffers/$id/mcq');
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

/////////////////Functions relative to the token management /////////

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

  static void removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
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
    var jsonMap = jsonDecode(response.body);
    User currentUser = User.empty();
    currentUser.email = jsonMap['mail'];
    currentUser.firstname = jsonMap['firstname'];
    currentUser.lastname = jsonMap['lastname'];
    currentUser.isCompany = jsonMap['isCompany'] == "true";
    currentUser.companyName = currentUser.isCompany ? jsonMap['company'] : "";
    currentUser.setId(jsonMap['_id']);
    return currentUser;
  }

  Client._internal();
}
