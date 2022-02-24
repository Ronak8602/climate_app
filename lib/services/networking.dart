import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  final url;
  Network(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;

    } else {
      print(response.statusCode);
      return 0;
    }
  }
}
