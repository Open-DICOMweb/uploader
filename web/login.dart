library odw.sdk.login;

import 'dart:html';
import '../lib/html/html_client.dart';
//import 'package:http/http.dart' as http;

/// ACR Connect Login
/// The login request is made to an application server.  It includes the
/// credentials of the user.  At a minimum this must include a [username]
/// and [password], but could include other authentication factors.
///
/// The login response should include:
///   1. The authentication cookie
///   2. CORS headers
///   3. Authorizations
///

//TODO:
//  1. Get the OpenId Request message format
//  2. How does the response send the identity token and authorization token
//  3. Define the JSON-LD payload for the user's trial/subject data

//TODO: move to html/user_agent.dart
class UserAgent {
  //TODO: add other appropriate fields
  static String host;
  static String language = "en-US";
  static String name = "ACR Web Client";
  static String version = "0.1.0-Dev.1.0";

  static get uaHeader => '$name($version)';
}

String username;
String password;
http.Client client;
String serverResponse;

Map headers = {
    "Origin": UserAgent.host,
    "Host": UserAgent.host,
    "Accept-Language": UserAgent.language,
    "Connection": "keep-alive",
    "User-Agent": UserAgent.uaHeader};

void submitForm(Event e) {
  e.preventDefault();
  client = new HttpClient();
  request.onReadyStateChange.listen(onData, onError: onError, onDone: onDone);
  String url = "http://127.0.0.1:4040/login";
  post(url, headers);
  request.send();
}

//TODO: this is a temporary response, make it real
void onData(_) {
  if (request.readyState == HttpRequest.DONE && request.status == 200) {
    // Data saved OK.
    serverResponse = 'Server Sez: ' + request.responseText;
  } else if (request.readyState == HttpRequest.DONE && request.status >= 400) {
    serverResponse = request.statusText + '\n' + request.responseText;
  }else if (request.readyState == HttpRequest.DONE && request.status == 0) {
    // Status is 0...most likely the server isn't running.
    serverResponse = 'No server';
  }
}

void onError(error, stacktrace) {
  //TODO: turn into log(error, stacktrace)
  print(error);
  print(stacktrace);
}

void onDone() {
  //TODO: turn into log handler
  print('Connection closed: ');
}

void resetForm(Event e) {
  e.preventDefault();
  username = "";
  password = "";
  serverResponse = "Data reset.";
}
