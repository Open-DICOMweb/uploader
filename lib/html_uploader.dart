library upload_file;

import 'dart:html';

import 'html_file_reader.dart';
import 'http_file_writer.dart';
//TODO: needs rewrite
/// Defines operation with the file. Mixes ui logic and uploading the file.
class HtmlUploader {
  //static String target = "http://localhost/uploader/api/Upload/UploadChunk";
  //static String mergeUrl = "http://localhost/uploader/api/Upload/MergeAll";
  //static String directoryName = "qw12";
  //static int sizeChunk = 10485760;
  //static var _mainDataMap = {};
  //Map<String, dynamic> spin = {};

  Uri targetUri;
  InputElement _fileInput;
  ButtonElement _startButton;
  HtmlFileReader reader;
  HttpFileWriter writer;

  /// Sets up initial ui settings
  HtmlUploader(this.targetUri) {
    // Create a new uploader for this server
    //reader = new HtmlFileReader(, maxChunkSize);
    // Retrieve [Elements] by 'id'
    //_fileInput = querySelector('#files');
    //_startButton = querySelector('#startUpload');
    // Create a Map of the key [Elements] retrieved by 'id'
    spin["total"] = querySelector("#total");
    spin["process"] = querySelector("#process");
    spin["progress"] = querySelector("#progress");
    // Retrieve [Elements] by 'class'
    spin["loading"] = querySelector(".spin.loading");
    spin["processing"] = querySelector(".spin.processing");
    _fileInput.onChange.listen((Event e) => _onFileInputChange());

    // Disable and hide the Start Upload button.
    _startButton.attributes['disabled'] = 'true';
    _startButton.style.visibility = 'hidden';
    _startButton.onClick.listen(_onStartUpload);

  }

  /// Handle select file [Event]. Sets up variable _file and ui settings
  void _onFileInputChange() {
    int length = _fileInput.files.length;
    if (length < 1) {
      _startButton.attributes['disabled'] = null;
      _startButton.style.visibility = 'hidden';
    } else {
      _startButton.attributes['disabled'] = 'true';
      _startButton.style.visibility = 'visible';
    }
    spin["total"].style.visibility = 'hidden';
    spin["progress"].style.visibility = 'hidden';
    spin["process"].style.visibility = 'hidden';
  }

  void createFileList(List<File> files) {}

  /// Handle start upload [Event].
  void _onStartUpload(Event e) {
    e.stopPropagation();
    e.preventDefault();
    _upload();
  }

  /// Main method. Sends first 6 chunks and defines handle,
  /// which sends next chunks (If the previous chunk has been upload successfully).
  /// We have 6 handles, because browsers support 6 simultaneous connections with one domain.
  void _upload() {
    spin["loading"].style.visibility = 'visible';
    spin["total"].style.visibility = 'visible';
    spin["progress"].style.visibility = 'visible';
    spin["progressValue"] = 0;
    spin["totalValue"] = fs.size;
    spin["total"].text = " of ${spin["totalValue"]} byte";
    spin["progress"].text = spin["progressValue"];
  }
}
