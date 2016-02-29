//TODO: copyright
library odw.servers.login;

/// File Upload Server
/// Primarily used for testing

//flush import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart';

import '../lib/core/system.dart';
import '../lib/http/format.dart' as fmt;

//TODO:
//  1. Add Login logic & page
//  2. Add logging
//  2. Add DICOMweb Request Validator
//  2. Add args for: url, baseDir, [what else]?
ArgResults results;

const String MODE = 'mode';
const String DEBUG = 'debug';
const String RELEASE = 'release';
const String PORT = 'port';
const String DIR = 'dir';
main(List<String> args) async {
  //TODO: create 'server_args' library
  //TODO: add CORS and test between two machines
  //TODO: test https
  String host;
  int port;
  Directory baseDir;

  //TODO: move parser login to odw.server.login.arg_parser.dart
  final parser = new ArgParser()
    ..addOption(MODE, abbr: 'm', defaultsTo: 'debug', help: 'The mode, either "debug" or "release"')
    ..addOption(PORT, abbr: 'p', defaultsTo: '4041', help: 'The port for this server')
    ..addOption(DIR, abbr: 'd', defaultsTo: '', help: 'The base directory for the server');

  results = parser.parse(args);

  // Get the hostname
  switch (results[MODE]) {
    case DEBUG:
      host = 'localhost';
      break;
    case RELEASE:
      host = Platform.localHostname;
      break;
    default:
      stderr.writeln('Invalid mode argument: ${results[MODE]}');
      exit(-1);
  }

  // Get the port number
  port = int.parse(results[PORT],
      onError: (String s) { stderr.writeln('Invalid "port" argument: $s'); });

  // Get the base directory
  String dir = results[DIR];
  if (dir != "") {
    if (FileSystemEntity.isDirectorySync(dir) ==
        FileSystemEntityType.DIRECTORY) {
      baseDir = new Directory(dir);
      Directory.current = baseDir;
    } else {
      stderr.writeln('Invalid "dir" argument: ${results[DIR]} does not exist');
      exit(-1);
    }
  } else {
    baseDir = Directory.current;
  }

  //TODO: end of 'server_args' library

  //TODO: make log(...)
  print(System.info('\nACR Connect Login Service:\n\tHost: $host\n\tPort: $port'));
  HttpServer server = await HttpServer.bind(host, port);
  await for (HttpRequest request in server) {
    handle(request);
  }
}

handle(HttpRequest req) async {
  String username;
  String password;

  if (req.method == "POST") {
    username = req.uri.queryParameters["username"];
    password = req.uri.queryParameters["password"];
    if (isValidUser(username, password)) {
      HttpResponse resp = req.response;
      resp.statusCode = HttpStatus.OK;
      addHeaders(resp, ContentType.JSON);
      resp.write(jsonPayload);
      resp.close();
      print('Successful login for $username');
    } else {
      HttpResponse resp = req.response;
      resp.statusCode = HttpStatus.BAD_REQUEST;
      resp.headers.contentType = ContentType.TEXT;
      resp.write('Login Server: invalid username or password');
      resp.close();
    }
  } else {
    print("Bad Method");
    HttpResponse resp = req.response;
    resp.statusCode = HttpStatus.BAD_REQUEST;
    resp.headers.contentType = ContentType.TEXT;
    //TODO? addHeaders(resp, ContentType.JSON);
    resp.write('Login Server: invalid Method: ${req.method}');
    resp.close();
  }
}

void addHeaders(HttpResponse resp, ContentType cType) {
  resp.headers.contentType = cType;
  resp.headers.add("ETag", 12345);
  resp.headers.add("Last-Modified", new DateTime.now());
  //TODO: this should be UserAgent.host
  resp.headers.add('Access-Control-Allow-Origin', '*');
  //TODO: fix for login
  resp.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS');
  //TODO: modify for login
  resp.headers.add('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
}

void addCorsHeaders(HttpResponse res) {
  //TODO: fix as above
  res.headers.add('Access-Control-Allow-Origin', '*');
  res.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.headers.add('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
}

// A silly username/password map
Map<String, String> users = {
  "jim": "philbin",
  "rima": "semaan",
  "devon": "philblin",
  "rachel": "philbin"
};

bool isValidUser(String username, String password) =>
    (password == users[username]) ?true : false;

String jsonPayload = '''
{"idToken": "foo",
 "authToken": "bar",
 "userData": {"trial": "bas"}
''';



