library odw.sdk.http.format;

import 'dart:io';

/// A library for formatting HTTP messages and their components
/// Designed to be imported as:
/// 'import "package:odwHttp/format" as fmt;'

/// Returns a [String] encoded as [JSON] with the [HttpRequest] contents.
String request(HttpRequest req, payload) => '''
{ @type: HttpRequest,
  conn: ${_fmtConnectionInfo(req.connectionInfo)},
  method: ${req.method},
  uri: ${req.uri},
  version: ${req.protocolVersion},
  headers: ${headers(req.headers)},
  payload: $payload }
''';

/// Returns a [String] encoded as [JSON] with the [HttpResponse] contents.
String clientResponse(HttpClientResponse resp, payload) => '''
{ @type: HttpResponse,
  conn: ${_fmtConnectionInfo(resp.connectionInfo)},
  status: ${resp.statusCode}(${resp.reasonPhrase}),
  headers: ${headers(resp.headers)},
  payload: $payload }
''';

String _fmtConnectionInfo(HttpConnectionInfo c) => '''{
    localPort: ${c.localPort},
    remoteAddress: ${c.remoteAddress},
    remotePort: ${c.remotePort} }''';

/// Returns a Json [Map] of the Http message [headers]
String headers(HttpHeaders headers) => mapToJson(headers);

//TODO: move to general formatter?
String mapToJson(map) {
  String s = '{\n';
  String _mapEntryFmt(String name, List<String> values) => s += '      $name: $values\n';
  map.forEach(_mapEntryFmt);
  s += '\t}';
  //print('s=$s');
  return s;
}



/* todo: flush
String requestToJson(HttpRequest req, payload) =>'''{
  "@type": "HttpRequest",
  "method": "${req.method}",
  "headers": ${fmtHeaders(req)},
  "payload": $payload
  }
''';

String fmtHeaders(req) {
  String s = '{\n';
  String f(String name, List<String> values) => s += '\t$name: $values\n';
  req.headers.forEach(f);
  s += '\t}';
  print('s=$s');
  return s;
}
*/
