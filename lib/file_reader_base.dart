library uploader.file_reader;

import 'dart:async';
///import 'dart:io';
//import 'dart:typed_data';

/// Use to keep track of a file being transferred in chunks.  It can also be used to
/// to get the data for a Progress Bar, for example.
///
/// [this] is used to allow a [File] to be read in chunks.  It can also be used to access
/// progress information.  The [position] in the file should only updated after the read
/// completes.
abstract class FileReaderBase {
  final int maxChunkSize;
  final int length;
  int _remaining;
  int _nChunksSent = 0;
  int _pos = 0;
  int end;
  int _size;


  FileReaderBase(this.length, this.maxChunkSize) {
    _remaining = length;
  }

  /// Returns the [path] of the file being transferred.
  String get path;

  /// The index of the current position in [this].
  int get position => _pos;

  /// Returns [true] if the file has been successfully transferred.
  bool get isComplete => _remaining <= 0;

  /// Returns the number of chunks in this file.
  int get nChunks => (length / maxChunkSize).ceil();

  /// Returns the number of [chunk]s sent so far.
  int get nChunksSent => _nChunksSent;

  /// Returns the current [chunk] of data.
  //TODO: flush Blob get chunk => _chunk;

  /// Returns a [String] that can be used in the Range header field.
  /// NB: This will only be accurate if called ???
  String get range => 'bytes=$_pos-$end';

  /// Returns the size of the next chunk of [file].
  int get chunkSize => (_remaining < maxChunkSize) ? _remaining : maxChunkSize;

  /// Prepare to read the next chunk.
  int preRead() {
    int _size = chunkSize;
    //TODO: throw an File I/O exception
    if (_size <= 0) throw "Error: no more chunks";
    return _size;
  }

  /// Update state after chunck is successfully read.
  void postRead() {
    _remaining -= _size;
    if (_remaining > 0) {
      _pos = _pos + _size;
      _nChunksSent++;
    }
  }

  /// Returns the next chunk of the [file] in a [Uint8List] [buffer].
  /// Buffer management is the callers responsibility.
  Future read([buffer]);

  /// Returns the next chunk of the [file] in a [Uint8List] [buffer].
  /// Buffer management is the callers responsibility.
  void readSync([buffer]);

  /// Returns the percentage of the file transferred so far.
  int get percentTransferred => (length - _remaining) ~/ length;

}
