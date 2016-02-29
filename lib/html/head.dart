library odw.sdk.html.head;

class Head {
  String title;
  String styleFile;  // Should include '.css'
  String dartFile;

  Head(this.title, {this.styleFile, this.dartFile});

  //TODO: validate the 'Meta' lines
  String get html => '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$title</title>
  <link rel="stylesheet" href="$styleFile">
  <script async src="$dartFile" type="application/dart"></script>
  <script async src="packages/browser/dart.js"></script>
</head>
''';
}
