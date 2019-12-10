
  import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../urls.dart';

Future<dynamic> loginUser(String email, String password) async {
  var uri = raizApi;
  BaseOptions options = BaseOptions(
      baseUrl: uri,
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
      });
  Dio dio = Dio(options);
    try {
      Options options = Options(
       //contentType: ContentType.parse('application/json') ,
      );

      Response response = await dio.post('/rest-auth/login/',
          data: {"username": email, "password": password}, options: options);

      if (response.statusCode == 200 || response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
 
  
        return response;
      } else{
        return response;
      }
    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }