import 'package:go_dely/core/exception.dart';
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/users/auth.dart';
import 'package:go_dely/domain/users/user.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepositoryImpl extends IAuthRepository {

  final IPetition petition;
  final SharedPreferencesAsync asyncPrefs;

  AuthRepositoryImpl({required this.petition, required this.asyncPrefs});

  @override
  Future<Result<String>> login(AuthDto dto) async{
    var queryParameters = {
      'user_email': dto.userEmail,
      'user_password': dto.userPassword,
    };

    final result = await petition.makeRequest(
      urlPath: '/auth/login',
      httpMethod: 'POST',
      body: queryParameters,
      mapperCallBack: (data) {
        if (data['error'] != null) {
          return data['error'].toString();
        }
        final String token = data['token'];
        print(token);
        return token;
      },
    );
    return result;
  }

  @override
  Future<Result<String>> register(User user) async {
    var queryParameters = {
      'user_email': user.email,
      'user_password': user.password,
    };

    var queryString = Uri(queryParameters: queryParameters).query;  //*terminar cuando este bien implmentado registro

    final result = await petition.makeRequest(
      urlPath: '/auth/register?$queryString',
      httpMethod: 'POST',
      mapperCallBack: (data) {
        final String token = data['token'];
        return token;
      },
    );
    return result;
  }
  
  @override
  Future<Result<String?>> getToken() async {
    final String? token;
    try {
      token = await asyncPrefs.getString('token');
      return Result.success<String?>(token);
    } catch (e) {
      return Result.failure<String?>(const CacheException());
    }
  }
  
  @override
  Future<Result<String>> setToken(String token) async {
    try {
      await asyncPrefs.setString('token', token);
      return Result.success<String>(token);
    } catch (e) {
      return Result.failure<String>(const CacheException());
    }
  }

  @override
  Future<Result<bool>> checkAuth(String token) async {

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer $token");
    final result = await petition.makeRequest(
      urlPath: '/auth/private',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        if (data['message'] == "Authorized") {
          print(token);
          return true;
        }
        return false;
      },
    );
    return result;
  }

}