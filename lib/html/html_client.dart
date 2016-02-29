//TODO copyright

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/browser_client.dart';

/// A library based on the "package:http/browser_client.dart" that allows HTTP clients
/// (either browser-based or standalone) to use the same interface to communicate with servers.
///
/// It implements a class method for each HTTP "method", along with some additional methods
/// such as [read] and [readBytes].
///
/// This class is a wrapper around the [BrowserClient] class, which implements the [send]
/// method used here.
///
/// For more fine-grained control over the request, use [send] (from [BrowserClient] instead.

class HtmlClient extends BrowserClient {

  HtmlClient() : super();

  /// Sends an HTTP HEAD request with the given headers to the given URL, which
  /// can be a [Uri] or a [String].
  Future<Response> head(url, Map<String, String> headers) {
    Request request = new Request("HEAD", url);
    request.headers = headers;
    send(request);
  }

  /// Sends an HTTP GET request with the given headers to the given URL, which
  /// can be a [Uri] or a [String].
  Future<Response> get(url, Map<String, String> headers) {
    Request request = new Request("GET", url);
    request.headers = headers;
    send(request);
  }

  /// Sends an HTTP POST request with the given headers and body to the given
  /// URL, which can be a [Uri] or a [String].
  ///
  /// [body] sets the body of the request. It can be a [String], a [List<int>]
  /// or a [Map<String, String>]. If it's a String, it's encoded using
  /// [encoding] and used as the body of the request. The content-type of the
  /// request will default to "text/plain".
  ///
  /// If [body] is a List, it's used as a list of bytes for the body of the
  /// request.
  ///
  /// If [body] is a Map, it's encoded as form fields using [encoding]. The
  /// content-type of the request will be set to
  /// `"application/x-www-form-urlencoded"`; this cannot be overridden.
  ///
  /// [encoding] defaults to UTF-8.
  Future<Response> post(url, Map<String, String> headers, {body, Encoding encoding}) {
    Request request = new Request("POST", url);
    request
        ..headers = headers
        ..body = body
        ..encoding = encoding;
    send(request);
  }

  /// Sends an HTTP PUT request with the given headers and body to the given
  /// URL, which can be a [Uri] or a [String].
  ///
  /// [body] sets the body of the request. It can be a [String], a [List<int>]
  /// or a [Map<String, String>]. If it's a String, it's encoded using
  /// [encoding] and used as the body of the request. The content-type of the
  /// request will default to "text/plain".
  ///
  /// If [body] is a List, it's used as a list of bytes for the body of the
  /// request.
  ///
  /// If [body] is a Map, it's encoded as form fields using [encoding]. The
  /// content-type of the request will be set to
  /// `"application/x-www-form-urlencoded"`; this cannot be overridden.
  ///
  /// [encoding] defaults to UTF-8.
  Future<Response> put(url, Map<String, String> headers, {body, Encoding encoding}){
    Request request = new Request("PUT", url);
    request
      ..headers = headers
      ..body = body
      ..encoding = encoding;
    send(request);
  }

  /// Sends an HTTP PATCH request with the given headers and body to the given
  /// URL, which can be a [Uri] or a [String].
  ///
  /// [body] sets the body of the request. It can be a [String], a [List<int>]
  /// or a [Map<String, String>]. If it's a String, it's encoded using
  /// [encoding] and used as the body of the request. The content-type of the
  /// request will default to "text/plain".
  ///
  /// If [body] is a List, it's used as a list of bytes for the body of the
  /// request.
  ///
  /// If [body] is a Map, it's encoded as form fields using [encoding]. The
  /// content-type of the request will be set to
  /// `"application/x-www-form-urlencoded"`; this cannot be overridden.
  ///
  /// [encoding] defaults to UTF-8.
  Future<Response> patch(url, Map<String, String> headers, {body, Encoding encoding}) {
    Request request = new Request("PATCH", url);
    request
      ..headers = headers
      ..body = body
      ..encoding = encoding;
    send(request);
  }

  /// Sends an HTTP Options request with the given headers to the given URL,
  /// which can be a [Uri] or a [String].
  ///
  Future<Response> options(url, Map<String, String> headers) {
    Request request = new Request("OPTIONS", url);
    request.headers = headers;
    send(request);
  }

  /// Sends an HTTP DELETE request with the given headers to the given URL,
  /// which can be a [Uri] or a [String].
  Future<Response> delete(url, Map<String, String> headers) {
    Request request = new Request("DELETE", url);
    request.headers = headers;
    send(request);
  }

  /// Sends an HTTP GET request with the given headers to the given URL, which
  /// can be a [Uri] or a [String], and returns a Future that completes to the
  /// body of the response as a String.
  ///
  /// The Future will emit a [ClientException] if the response doesn't have a
  /// success status code.
  Future<String> read(url, {Map<String, String> headers}) {
    return get(url, headers: headers).then((Response response) {
      _checkResponseSuccess(url, response);
      return response.body;
    });
  }

  /// Sends an HTTP GET request with the given headers to the given URL, which
  /// can be a [Uri] or a [String], and returns a Future that completes to the
  /// body of the response as a list of bytes.
  ///
  /// The Future will emit an [ClientException] if the response doesn't have a
  /// success status code.
  Future<Uint8List> readBytes(url, {Map<String, String> headers}) {
    return get(url, headers: headers).then((Response response) {
      _checkResponseSuccess(url, response);
      return response.bodyBytes;
    });
  }

  /// Throws an error if [response] is not successful.
  void _checkResponseSuccess(url, Response response) {
    if (response.statusCode < 400) return;
    var message = "Request to $url failed with status ${response.statusCode}";
    if (response.reasonPhrase != null) {
      message = "$message: ${response.reasonPhrase}";
    }
    if (url is String) url = Uri.parse(url);
    throw new ClientException("$message.", url);
  }

}






