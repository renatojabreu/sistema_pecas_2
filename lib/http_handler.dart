import 'package:http/http.dart' as http;

httpGet(String url, int attempts, int timeout) async {
  var parsedJson;
  bool success = false;
  int attempt = 0;
  while (!success && attempt < attempts) {
    attempt++;
    int timeout = 10;
    try {
      http.Response response = await http
          .post('http://' + ipServidor,
              headers: headers,
              body: jsonEncode(_dadosList + _pecasList),
              encoding: utf8)
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        // do something
      } else {
        // handle it
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
    if (!success) {
      sleep(const Duration(milliseconds: 500)); //sleep a bit between attempts
    }
  }
  return parsedJson;
}
