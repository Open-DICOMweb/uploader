library uploader.file_reader;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'file_reader_base.dart';

/// A [FileReader] based on 'dart:io'.  It can be used to read local files in
/// chunks for a HTTP client or server, but cannot be used from a browser
/// (use HtmlReadFile instead).
///
/// [this] is used to allow a [File] to be read in chunks.  It can also be used to access
/// progress information.  The position in the file [_pos] is only updated after the read
/// completes.
class FileReader extends FileReaderBase {
  final File file;
  final RandomAccessFile _raf;

  FileReader(File file, int maxChunkSize)
      :this.file = file,
        super(file.lengthSync(), maxChunkSize),
        _raf = file.openSync(mode: FileMode.READ);

  /// Returns the name of the file being transferred.
  String get path => file.path;

  Future<Uint8List> read([Uint8List buffer, bool isAsync = true]) async {
    preRead();
    if (isAsync) {
      buffer = await readAsync(buffer);
    } else {
      buffer = readSync(buffer);
    }
    postRead();
    return buffer;
  }

  /// Returns the next chunk of the [file] into [Uint8List] [buffer].
  /// Buffer management is the callers responsibility.
  Future<Uint8List> readAsync([Uint8List buffer]) async {
    preRead();
    await _raf.readIntoSync(buffer, position, end);
    postRead();
    return buffer;
  }

  /// Returns the next chunk of the [file] into [Uint8List] [buffer].
  /// Buffer management is the callers responsibility.
  Uint8List readSync([Uint8List buffer]) {
    preRead();
    _raf.readIntoSync(buffer, position, end);
    postRead();
    return buffer;
  }
}

