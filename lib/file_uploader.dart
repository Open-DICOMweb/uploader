library uploader.file_uploader;

import 'dart:io';
import 'dart:typed_data';

import 'file_reader.dart';
import 'http_file_writer.dart';

/// A File Uploader: Opens one or more local files and uploads them to an origin server.
/// Note: uses 'dart:io' so cannot be used with a browser.

//TODO: Open Issues
// 1. How to handle errors if they occur? Retry?  How many times?
// 2. Should we be able to cancel an upload?
// 3. Should we send these asynchronously?  How many outstanding messages should be allow?
// 4. Should we have a different target resource for single files and chunked files?
//TODO: this is a version that should work with 'dart:io'
// 10MB = 10485760 bytes
const defaultChunkSize = 1024 * 1024 * 10;

/// Creates a browser based file uploader given a [targetUri] origin server and an optional
/// [maxChunkSize].  If a file is larger than the[maxChunkSize], it is sent in separate chunks.
class FileUploader {
  /// The [Uri] of the origin server
  Uri targetUri;

  /// The max size of a single 'chunk' of a file.
  int maxChunkSize;
  FileReader reader;
 HttpFileWriter writer;

  /// Given a URI for the [targetUri] origin server, a [ProgressMeter], and
  /// an optional [maxChunkSize]; returns an file uploader.
  FileUploader(this.targetUri, [this.maxChunkSize = defaultChunkSize]);

  /// Uploads the [List] of [File]s to the [targetUri] Web server.
  //TODO: Should this be using a FileList?
  void uploadFiles(List<File> files) {
    var buffer = new Uint8List(maxChunkSize);
    for (int i = 0; i < files.length; i++) {
      File file = files[i];
      reader = new FileReader(file, maxChunkSize);
      writer = new HttpFileWriter(targetUri);
      reader.read(buffer);
      writer.write(buffer);
    }
  }

  void uploadDirectory(Directory dir,
      {String extension, bool recursive: false, bool followLinks: true}) {
    List<FileSystemEntity> entities = dir.listSync();
    var buffer = new Uint8List(maxChunkSize);
    for (int i = 0; i < entities.length; i++) {
      var entity = entities[i];
      if (entity is File) {
        reader = new FileReader(entity, maxChunkSize);
        writer = new HttpFileWriter(targetUri);
        for (int i = 0; i < reader.nChunks; i++) {
          var chunk = reader.readSync(buffer);
          writer.write(chunk);
        }
      }
    }
  }

//transferFile(FileReader reader, HttpWriter writer) {}
}

/** TODO: flush later
  /// Sends one chunk to the server.  For small files a chunk might
  /// contain the entire file.
  void _sendChunk(FileReader reader) {
    HttpClient client = new HttpClient();
    var completer = (reader.isLastChunk)? _fileCompleter : _chunkCompleter;
    client.onReadyStateChange.listen(completer);
    client.open('POST', '$target?path=${reader.path}&${reader.range}');
    //TODO: what about [ContentType] header field?
    client.setRequestHeader('Range', reader.range);
    //TODO: how to resend?
    Blob data = reader.nextChunk;
    client.send(data);
    print('_sendChunk - ${reader.path}:${reader.range}');
  }

  /// [Event] handler for all but last chunk.  Once one chunk has
  /// completed; it sends the next chunk.
  /// TODO: This could be much more asynchronous
  Function _chunkCompleter(FileReader fs) => (ProgressEvent e) {
    HttpRequest request = e.target;
    if (request.readyState == HttpRequest.DONE &&
        ((request.status == 206) || (request.status == 200))) {
      print("Chunk received - ${fs.range}");
      //TODO: instead of sending the next chunk this could just record that the chunk was
      //      received successfully.  Then when all chunks have been sent successfully
      //      the file would be marked complete.  This would mean having a list of
      //      [FileState]s.
      _sendChunk(fs);
    } else if (request.readyState == HttpRequest.DONE && request.status == 400) {
      print("error - ${request.statusText}");
      // resend chunk
      //TODO: is this the right thing to do?
      _sendChunk(fs);
    }
  };

  /// [Event] handler for last chunk.
  Function _fileCompleter(FileReader fs) => (ProgressEvent e) {
    HttpRequest request = e.target;
    if (request.readyState == HttpRequest.DONE && (request.status == 200)) {
      print("File Uploaded: ${fs.path} - ${request.statusText}");
      if (fs.isComplete) {
        _merge(fs);
      } else {
        throw "Error: file not complete";
      }
    } else if (request.readyState == HttpRequest.DONE && request.status == 400) {
      print("error - ${request.statusText}");
      //TODO: retry?  If so, how many times.
      _sendChunk(fs);
    }
  };

  /// Sends merge request to the server to merge chunks
  void _merge(FileReader fs) {
    HttpRequest xhr = new HttpRequest();
    xhr.onReadyStateChange.listen(_mergeCompleter);
    xhr.open('GET','$target/merge?path=${fs.path}');
    xhr.send(null);
  }

  void _mergeCompleter(ProgressEvent e) {
    var request = e.target;
    if (request.readyState == HttpRequest.DONE && request.status == 200) {
      print("Merge ee!");
    } else if (request.readyState == HttpRequest.DONE && request.status == 400) {
      print("Merge :(((((");
    }
  }
}
*/
