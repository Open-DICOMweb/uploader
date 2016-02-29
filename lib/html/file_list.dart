library uploader.html.file_list;

import 'dart:html';
import 'file.dart';

class HtmlFileList {
  FileList files;

  HtmlFileList(this.files) {
    var length = files.length;
    var list = [];
    for(int i = 0; i < length; i++) list.add(new HtmlFile(files[i]));
  }

  Element get element => new Element.html(table);

  String get table => '''
  <table>
    <thead id="file-table">
      <tr>
        <td>
          <input class="global-checkbox" type="checkbox" name="global" value="false"
                  title= "Select All Files">
        </td>
        <td>Filename</td>
        <td>Length</td>
        <td>Type</td>
        <td>Modified</td>
      </tr>
    </thead>
    $tbody
  </table>
''';
  /*
    <tfoot>
      <tr>
        <td><input type="checkbox" title= "Select All Files"></td>
        <td>Filename</td>
        <td>Length</td>
        <td>Type</td>
        <td>Modified</td>
      </tr>
    </tfoot>
    */

  String get tbody {
    String s = "";
    for(int i = 0; i < files.length; i++) {
      s += row(new HtmlFile(files[i]), i);
    }
    return '''
    <tbody>
    $s
    </tbody>
''';
  }

  String row(HtmlFile f, int i) => '''
    <tr>
      <td>
        <input class="file-checkbox" type="checkbox" name="cbox-$i" value="false" title="select file">
      </td>
      <td>${f.name}</td>
      <td>${f.size}</td>
      <td>${f.type}</td>
      <td>${f.date}</td>
    </tr>
''';
}
