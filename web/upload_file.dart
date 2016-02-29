library upload_file;

import 'dart:html';

/// Defines operation with the file. Mixes ui logic and uploading the file.
class UploadFile {
  static String uploadUrl = "http://localhost/uploader/api/Upload/UploadChunk";
  static String mergeUrl = "http://localhost/uploader/api/Upload/MergeAll";
  static String directoryName = "qw12";
  static int sizeChunk = 10485760;
  static var _mainDataMap = {};
  var spin = {};

  InputElement _fileInput;
  ButtonElement _startUpload;
  File _file;

  /**
   * Sets up initial ui settings
   *
   */
  UploadFile() {
    _fileInput = querySelector('#files');
    _fileInput.onChange.listen((e) => _onFileInputChange());
    _startUpload = querySelector('#startUpload');
    _startUpload.setAttribute('disabled', 'true');
    _startUpload.style.visibility = "hidden";
    _startUpload.onClick.listen(_onStartUpload);
  }

  /**
   * Handle Event of select the file. Sets up variable _file and ui settings
   *
   */
  void _onFileInputChange() {
    _fileInput.files.length == 1 ? _file = _fileInput.files[0] : _file = null;
    _file == null
        ? _startUpload.setAttribute('disabled', 'true')
        : _startUpload.attributes.remove('disabled');
    _startUpload.style.visibility = "visible";
    spin["total"] = querySelector("#total");
    spin["process"] = querySelector("#process");
    spin["progress"] = querySelector("#progress");
    spin["total"].style.visibility = 'hidden';
    spin["progress"].style.visibility = 'hidden';
    spin["process"].style.visibility = 'hidden';
  }

  /**
   * Handle Event of start upload. Begins uploading
   *
   */
  void _onStartUpload(e) {
    e.stopPropagation();
    e.preventDefault();
    _upload();
  }

  /**
   * Slices chunk and sends it to the server
   *
   */
  void _sendChunk(int start, int end, data, listen) {
    var xhr = new HttpRequest();
    xhr.onReadyStateChange.listen((e) => listen(e, data));
    xhr.open(
        'POST',
        '''$uploadUrl${data["uploadUrl"]}?filename=${_file.name}
                                &directoryname=${_mainDataMap["directoryName"]}
                                &chunkNumber=${data["chunkNumber"]}
                                &numberOfChunks=${_mainDataMap["numberOfChunks"]}''');
    var chunk = _file.slice(start, end);
    data["chunkSize"] = chunk.size;
    var formData = new FormData();
    formData.appendBlob("Slice", chunk);
    xhr.send(formData);
    print("_sendChunk - ${data["chunkNumber"]}");
  }

  /**
   * Sends request to the server to merge chunks
   *
   */
  void _merge() {
    spin["loading"].style.visibility = 'hidden';
    spin["processing"].style.visibility = 'visible';
    spin["process"].style.visibility = 'visible';
    spin["process"].text = 'file processing on the server';
    void onData(e) {
      var request = e.target;
      if (request.readyState == HttpRequest.DONE && request.status == 200) {
        print("Merge ee!");
        spin["processing"].style.visibility = 'hidden';
        spin["process"].text = 'success';
      } else if (request.readyState == HttpRequest.DONE &&
          request.status == 400) {
        print("Merge (((((");
      }
    }
    var xhr = new HttpRequest();
    xhr.onReadyStateChange.listen(onData);
    xhr.open(
        'GET',
        '''$mergeUrl?filename=${_file.name}
                                &directoryname=${_mainDataMap["directoryName"]}
                                &numberofChunks=${_mainDataMap["numberOfChunks"]}''');
    xhr.send(null);
  }

  /**
   * Main method. Sends first 6 chunks and defines handle,
   * which sends next chunks (If the previous chunk has been upload successfully).
   * We have 6 handles, because browsers support 6 simultaneous connections with one domain.
   *
   */
  void _upload() {
    spin["loading"] = querySelector(".spin.loading");
    spin["loading"].style.visibility = 'visible';
    spin["processing"] = querySelector(".spin.processing");
    spin["total"].style.visibility = 'visible';
    spin["progress"].style.visibility = 'visible';
    spin["progressValue"] = 0;
    spin["totalValue"] = 0;

    var size = _file.size;
    spin["totalValue"] = size;
    spin["total"].text = " of ${spin["totalValue"]} byte";
    spin["progress"].text = spin["progressValue"];
    var numberOfChunks = (size / sizeChunk).ceil();

    var start = 0;
    var end = sizeChunk;
    var numberOfSuccessfulUpload = 0;
    _mainDataMap = {
      "directoryName": directoryName,
      "numberOfChunks": numberOfChunks
    };

    /**
     * Handle Event of upload chunks.
     *
     */
    void onData(e, dm) {
      var request = e.target;
      if (request.readyState == HttpRequest.DONE && request.status == 200) {
        print("onData - ${dm["chunkNumber"] + 6}");

        numberOfSuccessfulUpload++;
        spin["progressValue"] += dm["chunkSize"];
        spin["progress"].text = "loaded ${spin["progressValue"]}";
        if (numberOfSuccessfulUpload == numberOfChunks) _merge();
        dm["chunkNumber"] += 6;
        if (dm["chunkNumber"] > numberOfChunks) return;

        /// simulate error
        // var rng = new Random();
        // if(rng.nextInt(100) > 20 ){
        start = (dm["chunkNumber"] - 1) * sizeChunk;
        end = start + sizeChunk; //}
        //else{
        //  start = 0;
        //  end = 0;
        //}
        _sendChunk(start, end, dm, onData);
      } else if (request.readyState == HttpRequest.DONE &&
          request.status == 400) {
        print("error - ${dm["chunkNumber"]}");
        start = (dm["chunkNumber"] - 1) * sizeChunk;
        end = start + sizeChunk;
        _sendChunk(start, end, dm, onData);
      }
    }

    void onData1(e, dm) => onData(e, dm);
    void onData2(e, dm) => onData(e, dm);
    void onData3(e, dm) => onData(e, dm);
    void onData4(e, dm) => onData(e, dm);
    void onData5(e, dm) => onData(e, dm);
    void onData6(e, dm) => onData(e, dm);

    for (var i = 1; i <= 6; i++) {
      if (start >= size) return;
      var dm = {};
      dm["chunkNumber"] = i;
      dm["uploadUrl"] = i;
      var on;
      switch (i) {
        case 1:
          on = onData1;
          break;
        case 2:
          on = onData2;
          break;
        case 3:
          on = onData3;
          break;
        case 4:
          on = onData4;
          break;
        case 5:
          on = onData5;
          break;
        case 6:
          on = onData6;
          break;
        default:
          break;
      }

      /// simulate error
      // var rng = new Random();
      // if(rng.nextInt(100) > 20 ) {
      _sendChunk(start, end, dm, on);
      // }else{
      //  _sendChunk(0, 0, dm, on);
      //}
      start = i * sizeChunk;
      end = start + sizeChunk;
    }
  }
}
