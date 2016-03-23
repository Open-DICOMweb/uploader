//TODO: add copyright
import 'dart:html';

import 'package:odwhtml/html.dart';
import 'example_data.dart';
import 'trial_fields.dart';

class FilesUploader {
  InputElement _user;
  InputElement _site;
  InputElement _system;
  InputElement _trial;
  InputElement _subject;
  InputElement _step;

  HtmlFileList files;
  FormElement _trialUploadData;
  FormElement _selectFiles;
  InputElement _files;

  Element _dropZone;
  TableElement _filesTable;
  CheckboxInputElement _allFilesCheckbox;
  CheckboxInputElement _fileCheckbox;
  ButtonElement _addFilesButton;
  OutputElement _output;

  //SelectElement _users =

  FilesUploader() {
    _user = document.querySelector('#user');
    _user.children = getUserList();
    _site = document.querySelector('#site');
    _site.children = getSiteList();
    _system = document.querySelector('#system');
    _trial = document.querySelector('#trial');

    _trialUploadData = document.querySelector('#trial-upload-data');
    _selectFiles = document.querySelector('#select-files');
    _files = document.querySelector('#files');

    _addFilesButton = document.querySelector("#add-files-button");

    _filesTable = document.querySelector('#files-table');
    _allFilesCheckbox = document.querySelector("#all-files-checkbox");
    //TODO: add _fileCheckbox

    //?? _files.onChange.listen((e) => _onFilesSelected());

    _dropZone = document.querySelector('#drop-zone');
    _dropZone.onDragOver.listen(_onDragOver);
    _dropZone.onDragEnter.listen((e) => _dropZone.classes.add('hover'));
    _dropZone.onDragLeave.listen((e) => _dropZone.classes.remove('hover'));
    _dropZone.onDrop.listen(_onDrop);

    _output = document.querySelector('#output');
  }

  void _onDragOver(MouseEvent e) {
    print('onDragOver');
    e.stopPropagation();
    e.preventDefault();
    e.dataTransfer.dropEffect = 'copy';
  }

  void _onDrop(MouseEvent e) {
    print('onDrop');
    e.stopPropagation();
    e.preventDefault();
    _dropZone.classes.remove('hover');
    _selectFiles.reset();
    print(e.dataTransfer.files);
    _onFilesSelected(e.dataTransfer.files);
  }

  //TODO: finish
  /// The checkbox on the File Table Header Row has been clicked.
  /// Toggle the state of the checkbox (checked or unchecked) and
  /// mark on files in the File Table with that state.
  void _onAllFileCheckboxClick(Event e) {
    ElementList<CheckboxInputElement> files = querySelectorAll("file-checkbox");
    for (CheckboxInputElement file in files) {
      file.checked = true;
    }
  }

  //TODO: finish if needed or flush
  /// A checkbox on a Table Row containing a file has been clicked.
  /// Add the file to the upload list
  void _onFileCheckboxClick(MouseEvent e) {}

  /*
  void _onFilesSelected(List<File> files) {
    print('Files Selected: ${_files.files}');

    for(var i = 0; i < files.length; i++) {
      print('$i: ${files[i].name}');
    }
    _output.nodes.clear();
    Element ulist = new Element.ul();
    for (File file in files) {
      var f = new HtmlFile(file);
      var item = new Element.li();
      // If the file is an image, read and display its thumbnail.
      //TODO: this might be part of HtmlFile
      if (f.type.startsWith('image')) item.nodes.add(f.thumbnail);
      item.nodes.add(f.element);
      ulist.nodes.add(item);
    }
    _output.nodes.add(ulist);
    Element table = files.table;
    _output.nodes.add(file(files));
  }
  */
  void _onFilesSelected(FileList files) {
    HtmlFileList htmlFiles = new HtmlFileList(files);
    Element table = new Element.html(htmlFiles.table);
    // _output.nodes.add(list);
    _output.nodes.add(table);
    _selectFiles.style.visibility = "hidden";
  }

  String table = '''
    <table id="table">
    <thead>
      <tr>
        <td><input type="checkbox"></td>
        <td>Word</td>
        <td>Number</td>
        <td>Array</td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><input type="checkbox"></td>
        <td>one</td>
        <td>1</td>
        <td>[1]</td>
      </tr>
      <tr>
        <td><input type="checkbox"></td>
        <td>two</td>
        <td>2</td>
        <td>[2]</td>
      </tr>
      <tr>
        <td><input type="checkbox"></td>
        <td>three</td>
        <td>3</td>
        <td>[3]</td>
      </tr>
    </tbody>
    <tfoot>
    <tr>
      <td>droW</td>
      <td>rebmuN</td>
      <td>yarrA</td>
    </tr>
    </tfoot>
  </table>
  ''';
}

void main() {
  new FilesUploader();
}

List<String> siteList = [
  "Columbia",
  "Duke",
  "Johns Hopkins East Baltimore",
  "Johns Hopkins Bayview",
  "Johns Hopkins Suburban",
];
