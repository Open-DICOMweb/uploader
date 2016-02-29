/// File Upload Server
/// Primarily used for testing

import 'dart:convert';
import 'dart:io';

main(List<String> args) async {
  HttpServer server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 4041);
  await for (HttpRequest request in server) {
    handle(request);
  }
}

handle(HttpRequest req) async {
  var payload;
  print(req.headers);
  var contentType = req.headers.contentType;
  if (contentType.mimeType == 'application/octet-stream') {
    var builder = new BytesBuilder();
    await req.fold(builder, (b, d) => b..add(d));
    payload = builder.takeBytes();
  } else {
    payload = await req.transform(UTF8.decoder).join();
  }
  print(toString(req, payload));
}

String toString(HttpRequest req, payload) =>
    'method: ${req.method}\n'
    'uri: ${req.uri}\n'
    'headers: ${fmtHeaders(req)  }\n'
    'payload: $payload\n';

String fmtHeaders(req) {
  var s = "{";
  for (var header in req.headers) {
    s += '\t${header.name}: ${header.value}\n';
  }
  return s += "}\n";
}
