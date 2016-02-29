library odw.sdk.html.table;

/// An HTML Table and its descendants
class Table {
  String id;
  String label;
  String caption;
  List<String> headers;
  List<String> headAlign;
  List<String> footers;
  List<String> footAlign;
  List<List> rows;
  List<String> toolTips;
  List<String> links;
  String cssFile;

  //TODO: add ColumnGroup class and Column class
  //ColGroup colgroup;
  THead header;
  TFoot footer;
  TBody body;

  Table(this.id, this.body, {this.caption, this.header, this.footer});

  String get toHtml => '''
<table id=$id>
  <caption>Table $label: $caption</caption>
  ${header.toHtml}
  ${body.toHtml}
  ${footer.toHtml}
</table>
''';
}

class TCell {
  String value;
  String toolTipIndex;
  String linkIndex;
}

/*
class Caption {
  String id;
  String number;
  String text;

  Caption(this.text);

  String get toHtml => '<caption id="$id">Table $number: $text</caption>\n';
}

class ColGroup {
  int span;
  List<int> cols;
  List<String> alignment;

  ColGroup({this.span, this.cols});

  String get html => (span != null) ?
      '<colgroup span=$span />' :
      '''
  <colgroup>
${genColumns}
  </colgroup
''';

  String genColumns() {
    var s = "";
    for(int in cols) {
      s += '    <col span="$int">\n';
    }
  }
}
*/
class THead {
  List<Column> headers;
  List<String> alignment;

  int get nColumns => headers.length;

  THead(this.headers);

  String get toHtml => '''
<thead id=????>
  <tr class="table.header">
    ${columnsToHtml(headers)}
  </tr>
</thead>
''';

  String columnsToHtml(List<Column> columns) {
    var s = "<tr>\n";
    for (Column c in columns) {
      s += '${c.toHtml}\n  ';
    }
    return s += "</tr>\n";
  }
}

class TFoot {
  List<Column> footers;
  List<String> alignment;

  int get nColumns => footers.length;

  TFoot(this.footers);

  String get toHtml => '''
<tfoot id=????>
  <tr class="table.footer">
    ${columnsToHtml()}
  </tr>
</tfoot>
''';

  String columnsToHtml() {
    var s = "<tr>\n";
    for (Column c in footers) {
      s += '${c.toHtml}\n  ';
    }
    return s += "</tr>\n";
  }
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
  Rows rows;

  TBody(this.rows);

  String get toHtml => '''
<tbody id=???>
  ${rows.toHtml}
</tbody>
''';
}

class Rows {
  List<List> data;

  Rows(this.data);

  String get toHtml {
    var s = "";
    //TODO: finish
    return s;
  }
}
