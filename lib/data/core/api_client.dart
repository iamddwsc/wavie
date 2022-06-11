import 'dart:io';

import 'package:http/http.dart';
import 'dart:convert';

import 'unauthorised_exception.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(Uri path) async {
    await Future.delayed(Duration(milliseconds: 500));
    try {
      final response = await _client.get(
        // '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}',
        // Uri.parse(ApiConstants.BASE_URL + ApiConstants.GET10)
        path,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: 10));
      //print(response.body);
      //print(response.reasonPhrase);
      //print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      //print(e is SocketException ? 'socket' : e);
      //throw Exception(e.toString());
      print(e);
      rethrow;
    }
  }

  dynamic post(Uri path, {Map<dynamic, dynamic>? params}) async {
    try {
      final response = await _client.post(
        //getPath(path, null),
        path,
        body: jsonEncode(params),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      //print(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw UnauthorisedException();
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // String getPath(String path, Map<dynamic, dynamic> params) {
  //   var paramsString = '';
  //   if (params.isNotEmpty) {
  //     //path += '?';
  //     params.forEach((key, value) {
  //       paramsString += '$key=$value&';
  //     });
  //     path = path.substring(0, path.length - 1);
  //   }
  //   return path;
  // }
}
