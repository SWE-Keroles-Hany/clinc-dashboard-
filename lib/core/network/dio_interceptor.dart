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
    // final token = sharedPreferences.getString("token");
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImZsdXR0ZXJAZ21haWwuY29tIiwibmFtZSI6ImZsdXR0ZXJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI0YjRkYmE0Yi1iZmZiLTQ1MzctOGE1Ni1kNjhkMDE3ZjQ2NWEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJQYXRpZW50IiwiZXhwIjoxNzc4NjczNzg5LCJpc3MiOiJUZWxlbWVkaWNpbmVBcHAiLCJhdWQiOiJUZWxlbWVkaWNpbmVBcHBVc2VycyJ9.h0VqDBONIAmYYqpo_mbDVH4opMoNAAXmVCWY9Z0ePZA";
    log("token  $token");
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}
