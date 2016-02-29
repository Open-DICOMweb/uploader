
import 'dart:io';
import 'dart:convert' show UTF8, JSON;

main() async {
  Map jsonData = {
    'name': 'Han Solo',
    'job': 'reluctant hero',
    'BFF': 'Chewbacca',
    'ship': 'Millennium Falcon',
    'weakness': 'smuggling debts'
  };

  var request = await new HttpClient().post(InternetAddress.LOOPBACK_IP_V4.host, 4041, '/file.txt');
  request.headers.contentType = ContentType.JSON;
  request.write(JSON.encode(jsonData));
  HttpClientResponse response = await request.close();
  await for (var contents in response.transform(UTF8.decoder)) {
    print(contents);
  }
}
