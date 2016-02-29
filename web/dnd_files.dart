import 'dart:convert' show HtmlEscape;
import 'dart:html';

class DndFiles {
  FormElement _readForm;
  InputElement _fileInput;
  Element _dropZone;
  OutputElement _output;
  HtmlEscape sanitizer = new HtmlEscape();

  DndFiles() {
    _output = document.querySelector('#list');
    _readForm = document.querySelector('#read');
    _fileInput = document.querySelector('#files');
    _fileInput.onChange.listen((e) => _onFileInputChange());

    _dropZone = document.querySelector('#drop-zone');
    _dropZone.onDragOver.listen(_onDragOver);
    _dropZone.onDragEnter.listen((e) => _dropZone.classes.add('hover'));
    _dropZone.onDragLeave.listen((e) => _dropZone.classes.remove('hover'));
    _dropZone.onDrop.listen(_onDrop);
  }

  void _onDragOver(MouseEvent event) {
    event.stopPropagation();
    event.preventDefault();
    event.dataTransfer.dropEffect = 'copy';
  }

  void _onDrop(MouseEvent event) {
    event.stopPropagation();
    event.preventDefault();
    _dropZone.classes.remove('hover');
    _readForm.reset();
    _onFilesSelected(event.dataTransfer.files);
  }

  void _onFileInputChange() {
    _onFilesSelected(_fileInput.files);
  }

  void _onFilesSelected(List<File> files) {
    _output.nodes.clear();
    var list = new Element.tag('ul');
    for (var file in files) {
      var item = new Element.tag('li');

      // If the file is an image, read and display its thumbnail.
      if (file.type.startsWith('image')) {
        var thumbHolder = new Element.tag('span');
        var reader = new FileReader();
        reader.onLoad.listen((e) {
          var thumbnail = new ImageElement(src: reader.result);
          thumbnail.classes.add('thumb');
          thumbnail.title = sanitizer.convert(file.name);
          thumbHolder.nodes.add(thumbnail);
        });
        reader.readAsDataUrl(file);
        item.nodes.add(thumbHolder);
      }

      // For all file types, display some properties.
      var properties = new Element.span();
      properties.innerHtml = (new StringBuffer('<strong>')
        ..write(sanitizer.convert(file.name))
        ..write('</strong> (')
        ..write(file.type != null ? sanitizer.convert(file.type) : 'n/a')
        ..write(') ')
        ..write(file.size)
        ..write(' bytes')
          // TODO(jason9t): Re-enable this when issue 5070 is resolved.
          // http://code.google.com/p/dart/issues/detail?id=5070
          // ..add(', last modified: ')
          // ..add(file.lastModifiedDate != null ?
          //       file.lastModifiedDate.toLocal().toString() :
          //       'n/a')
      ).toString();
      item.nodes.add(properties);
      list.nodes.add(item);
    }
    _output.nodes.add(list);
    _output.nodes.add(table);
  }

  Element table = new Element.html('''
    <table id="table">
    <thead>
      <tr>
        <td>Word</td>
        <td>Number</td>
        <td>Array</td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>one</td>
        <td>1</td>
        <td>[1]</td>
      </tr>
      <tr>
        <td>two</td>
        <td>2</td>
        <td>[2]</td>
      </tr>
      <tr>
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
  ''');
}

void main() {
  new DndFiles();
}
