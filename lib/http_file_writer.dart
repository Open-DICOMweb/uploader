// Copyright 2016, Open DICOMweb
// TODO: finish copyright
library uploader.http_writer;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class HttpFileWriter {
  Uri targetUri;
  HttpClient client;
  HttpClientRequest request;

  String get host => targetUri.host;
  int get port => targetUri.port;
  String get path => targetUri.path;

  HttpFileWriter(this.targetUri) {
    client = new HttpClient();

    client.openUrl("POST", targetUri)
      .then((HttpClientRequest request) {
      request.headers.contentType = ContentType.BINARY;
    });
  }

  void write(Uint8List buffer) {


  }
}
