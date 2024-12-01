import 'package:go_dely/core/result.dart';

abstract class IPetition {

  Future<Result<T>> makeRequest<T>({
    required String httpMethod,
    required String urlPath,
    required T Function(dynamic) mapperCallBack,
    Map<String, dynamic>? queryParams,
    dynamic body,
  });

  void updateHeaders({required String headerKey, required dynamic headerValue});
}