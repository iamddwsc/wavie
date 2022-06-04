import 'package:http/http.dart';
import 'dart:convert';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(Uri path) async {
    final response = await _client.get(
      // '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}',
      // Uri.parse(ApiConstants.BASE_URL + ApiConstants.GET10)
      path,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
