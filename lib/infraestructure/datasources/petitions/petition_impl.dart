import 'package:dio/dio.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/core/exception.dart';
import 'package:go_dely/core/result.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';

class PetitionImpl extends IPetition {
  final Dio dio;

  PetitionImpl() : dio = Dio();

  @override
  Future<Result<T>> makeRequest<T>({
      required String httpMethod, 
      required String urlPath, 
      required T Function(dynamic p1) mapperCallBack,
      Map<String, dynamic>? queryParams, 
      body
    }) async {
      try {
        final url = Environment.verdeAPI + urlPath;
        final response = await dio.request(
          url,
          data: body,
          options: Options(
            method: httpMethod,
          ),
          queryParameters: queryParams);
        return Result.success<T>(mapperCallBack(response.data));
      } 
      on DioException catch (e) {
        return Result.failure<T>(handleException(e));
      } 
      catch (e) {
        print(e);
        return Result.failure<T>(const UnknownException());
      } 
  }

ApplicationException handleException(DioException e) {
  switch (e.type) {
    case DioExceptionType.badResponse:
      final message = e.response?.data["message"];
      if (message is String) {
        return PermissionDeniedException(message: message);
      } else if (message is Map<String, dynamic>) {
        return PermissionDeniedException(message: message.toString());
      } else {
        return PermissionDeniedException(message: message?.toString() ?? 'Unknown error');
      }
    default:
      return const UnknownException();
  }
}

  @override
  void updateHeaders({required String headerKey, required headerValue}) {
    dio.options.headers[headerKey] = headerValue;
  }

}