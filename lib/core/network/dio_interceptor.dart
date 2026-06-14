import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("token");
    log("token  $token");
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}
