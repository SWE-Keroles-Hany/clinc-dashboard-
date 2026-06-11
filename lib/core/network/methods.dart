import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../error/failure.dart';

dynamic handleResponse(Response response) {
  final message = response.statusMessage ?? "Some Thing Went Wrong"; 
  if (response.statusCode == 200 || response.statusCode == 201) {
    return response.data;
  }

  throw Failure(message: message);
}

Never handleDioError(DioException e) {
  final r = e.response?.data;
  print(r);
  final r2 = r['errors'];

  String message = "Something went wrong";
  if (r is List) {
    print("Here 1 ");
    message = r[0]['description'];
  } else if (r2 is Map) {
    print("Here 2 ");

    message = r2.values.first.toString();
  }
  print("Here 3 ");

  throw Failure(message: message);
}
