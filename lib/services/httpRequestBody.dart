import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

Map<String, String> uriList = {
  "createFact": "http://104.197.184.236:8443/api/createUpdateFact",
  "updateChallenge": "http://104.197.184.236:8443/api/updateChallenge",
  "createChallenge": "http://104.197.184.236:8443/api/createChallenge",
  "employeeSignup": "http://104.197.184.236:8443/api/employeeSignup",
  "associateSignup": "http://104.197.184.236:8443/api/associateSignup",
  "employeeAuth": "http://104.197.184.236:8443/api/auth",
  "createSession": "http://104.197.184.236:8443/api/createSession",
  "getCategories": "http://104.197.184.236:8443/api/getInspiredCategories",
  "getDashBoardDetails": "http://104.197.184.236:8443/api/getDashboardDetails",
  "getUserDetalis": "http://104.197.184.236:8443/api/user",
  "getAllChallenges": "http://104.197.184.236:8443/api/getAllChallenges",
  "postStepData": "http://104.197.184.236:8443/api/stepsdata",
  "updateUserChallenge": "http://104.197.184.236:8443/api/updateUserChallenge",
  "getLiveSessions": "http://104.197.184.236:8443/api/getAllTrainingSession/",
  "postEditProfile": "http://104.197.184.236:8443/api/editProfile",
  "sendFeedDailyBack": "http://104.197.184.236:8443/api/feedback",
  "uploadImage": "http://104.197.184.236:8443/api/imageupload",
  "getAllFacts": "http://104.197.184.236:8443/api/getAllFacts",
  "deleteFact": "http://104.197.184.236:8443/api/deleteFact"
};

Future<Response> newHttpPost({String uri, Map<String, dynamic> body}) async {
  print("-->called httpPost PubilcHttpMeth");

  final headers = {'Content-Type': 'application/json'};

  String jsonBody = jsonEncode(body);
  print(jsonBody.toString() + "" + uri.toString());
  final encoding = Encoding.getByName('utf-8');

  Response response =
      await post(uri, headers: headers, body: jsonBody, encoding: encoding);

  int statusCode = response.statusCode; //yet to handle http exception
  String responseBody = response.body;
  return response;
}

Future<Response> newHttpPostAuth(
    {String uri, Map<String, dynamic> body}) async {
  print("-->called httpPost PubilcHttpMeth");

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': '${prefs.get('auth_token')}'
  };

  String jsonBody = jsonEncode(body);
  print(jsonBody.toString() + "" + uri.toString());
  final encoding = Encoding.getByName('utf-8');

  Response response =
      await post(uri, headers: headers, body: jsonBody, encoding: encoding);

  int statusCode = response.statusCode; //yet to handle http exception
  String responseBody = response.body;
  return response;
}

Future<Response> newHttpDeleteAuth({String uri}) async {
  print("-->called httpPost PubilcHttpMeth");

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': '${prefs.get('auth_token')}'
  };

  // String jsonBody = jsonEncode(body);
  // print(jsonBody.toString() + "" + uri.toString());
  // final encoding = Encoding.getByName('utf-8');

  Response response = await delete(
    uri,
    headers: headers,
  );

  int statusCode = response.statusCode; //yet to handle http exception
  String responseBody = response.body;
  return response;
}

Future<Response> newHttpGetAuth({String uri, Map<String, dynamic> body}) async {
  print("-->called httpGetAuth PubilcHttpMeth");

  Map<String, dynamic> headers = {
    'Authorization': prefs.get('auth_token').toString()
  };

  String jsonBody = jsonEncode(body);
  print(jsonBody.toString() + "" + uri.toString());
  final encoding = Encoding.getByName('utf-8');
  print(uri);
  print({'Authorization': prefs.get('auth_token').toString()});
  Response response = await get(uri,
      headers: {'Authorization': prefs.get('auth_token').toString()});

  int statusCode = response.statusCode; //yet to handle http exception
  String responseBody = response.body;
  return response;
}
