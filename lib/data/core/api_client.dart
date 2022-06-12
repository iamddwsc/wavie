import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'dart:convert';

import 'unauthorised_exception.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(Uri path, {String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      headers = {
        'Content-Type': 'application/json',
      };
    }
    await Future.delayed(Duration(milliseconds: 500));

    try {
      final response = await _client
          .get(
            // '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}',
            // Uri.parse(ApiConstants.BASE_URL + ApiConstants.GET10)
            path,
            headers: headers,
          )
          .timeout(Duration(seconds: 10));
      //print(response.body);
      //print(response.reasonPhrase);
      print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      //print(e is SocketException ? 'socket' : e);
      //throw Exception(e.toString());
      //print(e);
      rethrow;
    }
  }

  dynamic post(Uri path, {Map<dynamic, dynamic>? params, String? token}) async {
    //print('api_client' + jsonEncode(params));
    Map<String, String> headers = {};
    if (token != null) {
      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      headers = {
        'Content-Type': 'application/json',
      };
    }

    try {
      final response = await _client.post(
        //getPath(path, null),
        path,
        body: jsonEncode(params),
        headers: headers,
      );
      print(response.body);
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

  dynamic postWithImage(Uri path,
      {Map<dynamic, dynamic>? params, String? filepath, String? token}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${params!['token']}',
      };
      filepath = params['filepath'];
      Map<String, String> params2 = {
        'last_name': params['last_name'],
        'first_name': params['first_name'],
      };

      var request = MultipartRequest('POST', path)
        ..fields.addAll(params2)
        ..headers.addAll(headers)
        ..files.add(await MultipartFile.fromPath('image', filepath!));

      var streamedResponse = await request.send();
      var response = await Response.fromStream(streamedResponse);
      print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
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
