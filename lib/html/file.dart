library uploader.html.file;

import 'dart:convert';
import 'dart:html';


class HtmlFile {
  static String sanitize(String s) => HTML_ESCAPE.convert(s);
  File file;

  HtmlFile(this.file);

  String get name => sanitize(file.name);
  String get type => (file.type == null) ? "n/a" : sanitize(file.type);
  int    get size => file.size;
  String get date => (file.lastModifiedDate == null) ? "n/a" : file.lastModifiedDate.toString();

  Element get thumbnail {
    var span = new Element.tag('span');
    var reader = new FileReader();

    // Set up listener
    reader.onLoad.listen((Event e) {
      var thumbnail = new ImageElement(src: reader.result);
      thumbnail.classes.add('thumb');
      thumbnail.title = name;
      span.nodes.add(thumbnail);
    });

    // Read the Thumbnail Image File
    reader.readAsDataUrl(file);
    return span;
  }

  /// Returns an Html [Element] containing the file's properties.
  Element get element => new Element.html(toHtml());

  toHtml() =>
      '<span><strong>${file.name}</strong> ($type) $size bytes, last modified: $date</span>';
}
