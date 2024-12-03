import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/users/auth.dart';
import 'package:go_dely/domain/users/user.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';


class AuthRepositoryImpl extends IAuthRepository {

  final IPetition petition;

  AuthRepositoryImpl({required this.petition});

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
          return "error";
        }
        final String token = data['token'];
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

}