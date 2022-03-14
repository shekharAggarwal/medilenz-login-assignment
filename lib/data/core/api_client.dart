import 'dart:convert';

import 'package:http/http.dart';

import 'api_constants.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.get(
      getPath(path, params),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  }

  dynamic post(String path,
      {Map<dynamic, dynamic>? params, Map<dynamic, dynamic>? urlParams}) async {
    final response = await _client.post(
      getPath(path, urlParams),
      body: jsonEncode(params),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      bool isFirst = true;
      params?.forEach((key, value) {
        if (isFirst) {
          paramsString += '$value';
          isFirst = false;
        } else {
          paramsString += '/$value';
        }
      });
    }

    return Uri.parse(
        '${ApiConstants.BASE_URL}$path/$paramsString/${ApiConstants.TOKEN}');
  }
}
