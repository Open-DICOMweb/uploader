//TODO: copyright
//library acr.html.labelled_input;

//import 'dart:html';

Map<String, String> ids = {
  "label": "User",
  "id": "user",
  "tip": "Username",
  "placeholder": "Username",
};

class Field {
  final String label;
  final String id;
  final String tip;

  const Field(this.label, this.id, this.tip);

  static const user = const Field("User", "user", "Username");
  static const site = const Field("Site", "site", "Site Name");
  static const project = const Field("Project", "project", "Project Name");
  static const program = const Field("Program", "program", "Program Name");
  static const system = const Field("System", "system", "Health System Name");
  static const subject = const Field("Subject", "subject", "Subject Code");
  static const step = const Field("Step", "step", "Trial Step Number");
}

List<String> users = ["jfphilbin", "twang", "jsmith"];
List<String> sites = ["Columbia", "Yale", "Hopkins", "Duke", "Penn"];

//LabelElement toLabelElement(Field field, List<String> dropdown) =>
//  new Element.html(toInputList(field, dropdown));

String toInputList(Field f, List<String> dropdown) {
  var id = f.id;
  String s = '''
<div class="field">
  <label class="label">${f.label}:
    <input type="text" class="input-list" id="$id-input" list="$id-datalist"
           title="${f.tip}" placeholder="${f.placeholder}">
  </label>
  ${toDatalist(f.id, dropdown)}
</div>
''';
  return s;
}

String toDatalist(String id, List<String> list) {
  var out = '<datalist id="$id-datalist">\n';
  for (String s in list) {
    //TODO: optimize next line
    out += '    <option class="option" value="$s"/>\n';
  }
  return out += '  </datalist>';
}

String toSelect(Field f, List<String> list) {
  var id = f.id;
  String s = '''
<div class="field">
  <label class="label" id="$id-label">${f.label}</label>
  <select type="text" class="input-list" id="$id-input" list="$id-datalist" title="${f.tip}">
    ${toSelectOptions(f.id, list)}
  </select>
</div>
''';
  return s;
}

String toSelectOptions(String id, List<String> list) {
  var out = "";
  for (String s in list) {
    var val = s.toLowerCase();
    out += '  <option class="option" value="$val">$s</option>\n';
  }
  return out;
}

main() {
  //print(toDatalist(test.id, list));
  print(toSelect(Field.user, users));
  print(toSelect(Field.site, sites));
  //print(toInputList(test, list));
  //print(toLabelElement(test, list));
}
