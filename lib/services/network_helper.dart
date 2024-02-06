import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  static final NetworkHelper _singleton = NetworkHelper._internal();

  factory NetworkHelper() {
    return _singleton;
  }

  NetworkHelper._internal();

  Future<dynamic> getData(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      throw 'Failed to load data';
    }
  }
}
