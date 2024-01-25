import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import './error/exceptions.dart';
import './network/data_source_url.dart';

class RemoteDataProvider {
  final http.Client client;

  RemoteDataProvider({required this.client});

  Future<dynamic> sendData({
    required String url,
    required Map<String, dynamic> body,
    required retrievedDataType,
    dynamic returnType,
  }) async {
    log('send data lunched ');

    log('body is ' + body.toString());
    log("I am here " + url);

    final response = await client.get(
      Uri.parse(DataSourceURL.baseUrl +
          url +
          "?api_key=zaCELgL.0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx"),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${body["api_token"] ?? ""}'
      },
    );

    log(DataSourceURL.baseUrl +
        url +
        "?api_key=zaCELgL.0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx");
    log("response.body " + response.body.toString());
    log(response.statusCode.toString());
    // log("returnType "+returnType.toString());

    if (response.statusCode == 200) {
      log('the status code is 200');
      if (returnType == List) {
        final List<dynamic> data = json.decode(response.body);
        log('the data data type is List');
        log("the data from return type is ${retrievedDataType.fromJsonList(data)}");

        return retrievedDataType.fromJsonList(data);
      } else if (returnType == int) {
        final dynamic data = response.body;
        return data;
      } else if (returnType == String) {
        print('the data is string ');
        final dynamic data = json.decode(response.body);
        return data;
      } else {
        final dynamic data = json.decode(response.body);
        log('remote data provider is $data');

        if (data is List) {
          if (data.isEmpty) {
            log('data exception');
            throw EmptyException();
          } else {
            print('data is not empty');
          }
        }

        print('data is $data');
        return retrievedDataType.fromJson(data);
      }
    } else if (response.statusCode == 201) {
      return 1;
    } else if (response.statusCode == 500) {
      throw ServierExeption();
    } else if (response.statusCode == 404) {
      throw NotFound();
    } else if (response.statusCode == 319) {
      throw BlockedUser();
    } else if (response.statusCode == 407) {
      throw NotAvilable();
    }
  }
}
