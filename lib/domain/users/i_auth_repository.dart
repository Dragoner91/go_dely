import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/users/auth.dart';
import 'package:go_dely/domain/users/user.dart';

abstract class IAuthRepository{

  Future<Result<String>> login(AuthDto dto);

  Future<Result<String>> register(User user);

  Future<Result<String?>> getToken();

  Future<Result<String>> setToken(String token);

}