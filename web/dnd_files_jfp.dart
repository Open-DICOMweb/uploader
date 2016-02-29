
import 'dart:html';

import 'package:uploader/uploader.dart';

class DndFiles {
  HtmlFileList files;
  FormElement _form;
  InputElement _files;
  Element _dropZone;
  OutputElement _output;

  DndFiles() {
    _output = document.querySelector('#list');
    _form = document.querySelector('#read');
    _files = document.querySelector('#files');
    _files.onChange.listen((e) => _onFileInputChange());

    _dropZone = document.querySelector('#drop-zone');
    _dropZone.onDragOver.listen(_onDragOver);
    _dropZone.onDragEnter.listen((e) => _dropZone.classes.add('hover'));
    _dropZone.onDragLeave.listen((e) => _dropZone.classes.remove('hover'));
    _dropZone.onDrop.listen(_onDrop);
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
    _form.reset();
    print(e.dataTransfer.files);
    _onFilesSelected(e.dataTransfer.files);
  }

  void _onFileInputChange() {
    print('onFileInputChange');
    _onFilesSelected(_files.files);
  }

  //TODO: finish
  /*
  void _onCheckboxClick(MouseEvent e) {
    if (e.) {

    }
  }
  */
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
  new DndFiles();
}
