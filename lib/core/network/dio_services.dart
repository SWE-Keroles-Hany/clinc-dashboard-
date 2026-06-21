import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/core/network/api_services.dart';
import 'package:clinc_dashboard/core/network/dio_interceptor.dart';
import 'package:clinc_dashboard/core/network/methods.dart';
import 'package:dio/dio.dart';

import 'api_constants.dart';

class DioServices implements APIServices {
  final Dio dio;
  DioServices(this.dio) {
    dio.options.baseUrl = ApiEndPoints.baseURL;
    dio.options.headers = {
      'Accept': 'application/json',
    };
    dio.interceptors.add(DioInterceptors());
  }

  @override
  Future<dynamic> post({
    required String endPoint,
    Object? data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        data: data,
        queryParameters: queryParams,
        options: options,
      );
      return handleResponse(response);
    } on DioException catch (exception) {
      final message =
          (exception.response?.data is List &&
              exception.response?.data.isNotEmpty)
          ? exception.response?.data[0]['description'] ?? ""
          : exception.response?.data['description']?.toString() ??
                exception.message ??
                "";

      throw Failure(message: message);
    }
  }

  @override
  Future<dynamic> put({
    required String endPoint,
    Object? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.put(
        endPoint,
        data: data,
        queryParameters: queryParams,
      );
      return handleResponse(response);
    } on DioException catch (exception) {
      final message =
          (exception.response?.data is List &&
              exception.response?.data.isNotEmpty)
          ? exception.response?.data[0]['description'] ?? ""
          : exception.response?.data['description']?.toString() ??
                exception.message ??
                "";

      throw Failure(message: message);
    } catch (e) {
      print(e.toString());
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<dynamic> patch({
    required String endPoint,
    Object? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.patch(
        endPoint,
        data: data,
        queryParameters: queryParams,
      );
      return handleResponse(response);
    } on DioException catch (exception) {
      final message =
          (exception.response?.data is List &&
              exception.response?.data.isNotEmpty)
          ? exception.response?.data[0]['description'] ?? ""
          : exception.response?.data['description']?.toString() ??
                exception.message ??
                "";

      throw Failure(message: message);
    } catch (e) {
      print(e.toString());
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.get(endPoint, queryParameters: queryParams);
      return handleResponse(response);
    } on DioException catch (exception) {
      final message =
          (exception.response?.data is List &&
              exception.response?.data.isNotEmpty)
          ? exception.response?.data[0]['description'] ?? ""
          : exception.response?.data['description']?.toString() ??
                exception.message ??
                "";
      print("${exception.response?.data}");

      throw Failure(message: message);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<dynamic> delete({
    required String endPoint,
    Object? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.delete(
        endPoint,
        data: data,
        queryParameters: queryParams,
      );
      return handleResponse(response);
    } on DioException catch (exception) {
      throw Failure(message: exception.message ?? "");
    } catch (_) {
      throw Failure(message: "Some Thing Went Wrong");
    }
  }
}
