
import 'dart:io';
import 'dart:convert' show UTF8, JSON;

import '../lib/core/system.dart';
import '../lib/http/format.dart' as fmt;

Map jsonData = {
  'name': 'Han Solo',
  'job': 'reluctant hero',
  'BFF': 'Chewbacca',
  'ship': 'Millennium Falcon',
  'weakness': 'smuggling debts'
};

main() async {
  print(System.info('Simple Client'));

  HttpClient client = await new HttpClient();
  var request = await client.post('localhost', 4041, '/file.txt');
  request.headers.contentType = ContentType.JSON;
  request.write(JSON.encode(jsonData));
  HttpClientResponse response = await request.close();

  await for (var contents in response.transform(UTF8.decoder)) {
    //print("contents=$contents");
    if (contents == null) contents = "No Payload!";
    print(fmt.clientResponse(response, contents));
    //print(contents);
  }
}
