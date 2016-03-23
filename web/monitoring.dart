// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This is a port of "Reading Files in JavaScript Using the File APIs" to Dart.
// See: http://www.html5rocks.com/en/tutorials/file/dndfiles/

import 'dart:html';
import 'dart:math';
import 'dart:async';

typedef void SetProgress(int value);

class Monitoring {
  FileUploadInputElement _fileInput;
  ProgressElement _progressBar;
  ButtonElement _cancelButton;
  DivElement _loading;
  SpanElement _filename;
  SpanElement _loadPercent;
  FileReader _reader;
  FileList _files;
  FileLoader _loader;
  int progress = 0;

  Monitoring() {
    _progressBar = querySelector('#progress-bar');
    _fileInput = document.querySelector('#files');
    _cancelButton = querySelector('#cancel-read');
    _loading = querySelector('#loading');
    _filename = querySelector('#filename');
    _loadPercent = querySelector('#load-percent');

    // Set up event handlers
    _fileInput.onChange.listen(_onFilesSelected);

    // Cleanup from load file loaded
    //_progressBar.classes.remove('loading');


  }

  void _onFilesSelected(Event e) {
    _files = _fileInput.files;
    print('Files Selected:');
    for (File file in _files) {
      print('\t ${file.name}');
    }

    _filename.text = "File: ${_files[0].name}\n Loading...\n";
    _progressBar.value = 0;
    _progressBar.text = "0%";
    progressShow();

    // Reset progress indicator on new file selection.
    _loader = new FileLoader(_fileInput.files[0], setProgress);
    _cancelButton.onClick.listen(_loader.onCancel);
  }

  void setProgress(int value) {
    if (value < 0) {
      progressCancelled();
    } else if (value >= 100) {
      progressComplete();
    } else {
      value = min(100, max(0, value));
      _progressBar.value = value;
      _progressBar.text = '${value}%';
      _loadPercent.text = '$value%';
    }
  }

  void progressComplete() {
    _filename.text = "File: ${_files[0].name}\n ...Loaded\n";
    progressHide();
  }

  void progressCancelled() {
    _filename.text = "File: ${_files[0].name}\n ...Cancelled!\n";
    progressHide();
  }

  void progressShow() {
    _cancelButton.classes.add("loading");
    _progressBar.classes.add("loading");
  //  _loading.style.visibility = "visable";
  //  _loading.style.opacity = "1.0";
    _loading.classes.add("loading");
  }

  void progressHide() {
    _progressBar.style.visibility = "hidden";
    _progressBar.classes.remove("loading");
    _loading.classes.remove("loading");
    _loadPercent.text = "";
    _cancelButton.classes.remove("loading");
  }
}

//TODO this could be a static class
class FileLoader {
  File file;
  SetProgress setProgress;
  FileReader _reader;
  int _nChunks = -1;
  int _chunksRead = 0;
  int _length;
  int _remaining;
  int _maxChunkSize = 1024 * 1024;
  bool abort = false;
  String error;

  //int size;
  int _pos;
  int _end;

  int get chunkSize => (_remaining < _maxChunkSize) ? _remaining : _maxChunkSize;

  int get _percentLoaded => ((_chunksRead / _nChunks) * 100).round().toInt();

  FileLoader(this.file, this.setProgress) {
    print('Creating FileLoader');
    print('\tfile: ${file.name}, length: ${file.size}, maxChunkSize: $_maxChunkSize');

    _length = file.size;
    _remaining = _length;
    _nChunks = (_length / _maxChunkSize).ceil();
    _chunksRead = 0;
    _pos = 0;
    _end = _pos + chunkSize;
    print('\tnChunks: $_nChunks, remaining: $_remaining');

    // Set up handlers and begin reading the file.
    _reader = new FileReader();
    _reader.onError.listen(_onError);
    // _reader.onProgress.listen(_onProgress);
    _reader.onAbort.listen(_onAbort);
    // _reader.onLoadStart.listen(_onLoadStart);
    // _reader.onLoad.listen(_onLoad);
    _reader.onLoadEnd.listen(_onLoadEnd);
    _readNextChunk();
  }

  void _readNextChunk() {
    if (abort) {
      _reader.abort();
    } else {
      Blob blob = file.slice(_pos, _end);
      print('**** _readNextChunk: ${file.name}');
      print('\tchunk: $_chunksRead, pos: $_pos, end: $_end, size: ${blob.size}');
      _reader.readAsArrayBuffer(blob);
    }
  }

  void _onLoadStart(Event e) {
    print('onLoadStart: ${file.name}');
    print('\tpos: $_pos, end: $_end');
  }

  void _onLoadEnd(Event e) {
    //print('onLoadEnd: ${file.name}');
    //print('\tfile: ${file.name}, length: ${file.size}, maxChunkSize: $_maxChunkSize');
    _chunksRead++;
    if (abort) {
      _reader.abort();
      setProgress(-1);
    } else if(_chunksRead < _nChunks) {
      _pos = _end;
      _end = _pos + chunkSize;
      //print('\tchunksRead: $_chunksRead, percent: $_percentLoaded');
      //print('\tpos: $_pos, end: $_end');
      setProgress(_percentLoaded);
      _readNextChunk();
      sleep(2000);
    } else {
      print('\tfinished Loading');
      setProgress(100);
    }
  }

  //TODO: make this work
  Future sleep(int milliseconds) async {
    //var rnd = new Random();
    Completer completer = new Completer();
    void finished() => completer.complete();
    Duration duration = new Duration(milliseconds: milliseconds);
    Timer timer = new Timer(duration, finished );
    print('sleeping...');
    await timer;
    print('done.');

  }

  void onProgress(ProgressEvent event) {
    print('onProgress:');
    print('\tComputable: ${event.lengthComputable}');
    if(event.lengthComputable) {
      print('\tLoaded: ${event.loaded}, Total: ${event.total}');
      setProgress(_percentLoaded);
    }
  }

  void onCancel(Event e) {
    print('onCancel:');
    print('\tFile Read Cancelled');
    if(_reader != null) _reader.abort();
    abort = true;
  }

  void _onAbort(Event e) {
    print('onAbort:');
    print('\tFile Read Aborted');
    abort = true;
    if(_reader != null) _reader.abort();
    window.alert('File read aborted.');
  }

  //TODO: add more errors
  void _onError(Event e) {
    print('onError:');
    print('\tError: ${_reader.error.name}');
    abort = true;
    if(_reader != null) _reader.abort();
    switch(_reader.error.code) {
      case FileError.NOT_FOUND_ERR:
        window.alert('File not found!');
        break;
      case FileError.NOT_READABLE_ERR:
        window.alert('File is not readable.');
        break;
      case FileError.ABORT_ERR:
        break;
      // no-op.
      default:
        window.alert('An error occurred reading this file.');
        break;
    }
  }
}

void main() {
  new Monitoring();
}
