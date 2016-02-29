library uploader.files_table;

import 'table.dart';

class FilesTable extends Table {

  FilesTable(String id, TBody body, {
      String caption: "",
      String colGroup: "",
      THead header,
      TFoot footer})
      : super(id, body, caption: caption, colGroup: colGroup, header: header, footer: footer);

  String get toHtml => '''
<table id=$id>
  ${caption.toHtml}
  ${header.toHeaderHtml}
  ${body.toHtml}
  ${header.toHeaderHtml}
</table>
''';
}

/** TODO: remove
class Caption {
  String text;

  Caption(this.text);
  String get toHtml => '<caption>$text</caption>\n';
}

class THead {
  List<Column> headers;
  List<Column> footers;

  THead(this.headers, [this.footers]);

  String get toHeaderHtml => '''
<thead id=????>
  <tr class="table.header">
    ${columnsToHtml(headers)}
  </tr>
</thead>
''';

  String get toFooterHtml => '''
<tfoot id=????>
  <tr class="table.header">
    ${columnsToHtml(headers)}
  </tr>
</tfoot>
''';

  String columnsToHtml(List<Column> columns) {
    var s = "<tr>\n";
    for(Column c in columns) {
      s += '${c.toHtml}\n  ';
    }
    return s += "</tr>\n";
  }

class Column {
  String name;
  String id;
  String style;
  String justify;

  Column(this.name, {this.id, this.style, this.justify});

  String get toHtml => '<th id="$id">$name</td>\n';
}

class TBody {
  String id;
  List<List<String>> rows;

  TBody(this.rows);

  String get toHtml => '''
<tbody id=???>
  ${rows.toHtml}
</tbody>
''';
}
**/
