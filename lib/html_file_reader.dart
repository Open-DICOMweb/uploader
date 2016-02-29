library uploader.html_file_reader;

import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'file_reader_base.dart';

class HtmlFileReader extends FileReaderBase {
  final File file;
  final int maxChunkSize;
  final reader = new FileReader();

  String get path => file.name;

  HtmlFileReader(File file, int maxChunkSize, [String contentType])
      :this.file = file,
        this.maxChunkSize = maxChunkSize,
        //this.blob = new Blob([new Uint8List(maxChunkSize)]),
        super(file.size, maxChunkSize) {
  }

  /*
  Uint8List read([Uint8List buffer, bool isAsync]) {
    preRead(buffer);
    (isAsync) ? readAsync() : readSync();
    postRead();
    return blob;
  }
  */

  /// Returns the next chunk of the [file] into [Uint8List] [buffer].
  /// Buffer management is the callers responsibility.

  Future<Uint8List> readSync([buffer]) async {
    preRead();
    FileReader reader = new FileReader();
    await reader.readAsArrayBuffer(file.slice(position, end));
    Uint8List buffer = reader.result;
    postRead();
    return buffer;
  }

  /// Returns the next chunk of the [file] into [Uint8List] [buffer].
  /// Buffer management is the callers responsibility.
  Future<Uint8List>  read([Uint8List buffer]) async {
  FileReader reader = new FileReader();
  /*
  reader.onLoadEnd.listen((Event e) {
    buffer = reader.result;
    print(buffer.runtimeType);
    });
  */
  preRead();
  await reader.readAsArrayBuffer(file.slice(position, end));
  postRead();
  return reader.result;
  }
}
