abstract class APIServices {
  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic> queryParams,
  });

  Future<dynamic> post({
    required String endPoint,
    Object? data,
    Map<String, dynamic> queryParams,
  });
  Future<dynamic> delete({
    required String endPoint,
    Object? data,
    Map<String, dynamic> queryParams,
  });
  Future<dynamic> put({
    required String endPoint,
    Object? data,
    Map<String, dynamic> queryParams,
  });
  Future<dynamic> patch({
    required String endPoint,
    Object? data,
    Map<String, dynamic> queryParams,
  });
}
