import 'dart:convert';
import 'dart:developer';


import 'package:hikayati_app/dataProviders/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider {
  SharedPreferences sharedPreferences;

  LocalDataProvider({required this.sharedPreferences});

  Future<void> cacheData({required String key,required dynamic data,}) {
    log("setting sharedPreferences");
    log("key $key");
    log('cached data is $data');
    return sharedPreferences.setString(key, json.encode(data));
  }

  dynamic getCachedData({required String key,required retrievedDataType,dynamic returnType,}) {
    try {
      if (sharedPreferences.getString(key) != null) {
        if (returnType == List) {
          final List<dynamic> data = json.decode(
            sharedPreferences.getString(key)??'',
          );

                  ///productsModel
          return retrievedDataType.fromJsonList(data);
        } else if (returnType == String) {
          final dynamic data = json.decode(
            sharedPreferences.getString(key)??'',
          );

          return data;
        } else {
          final dynamic data = json.decode(
            sharedPreferences.getString(key)??'',
          );

          try {
            return retrievedDataType.fromJson(data);
          } catch (e) {
            return data;
          }
        }
      }
      else {
        throw CacheException();
      }
    } catch (_) {
      throw CacheException();
    }
  }

  Future<bool> clearCache({
    required String key,
  }) {
    return sharedPreferences.remove(key);
  }




}



