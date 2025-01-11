import 'package:go_dely/core/result.dart';

class LoginDto {
  final String email;
  final String password;

  LoginDto({
    required this.email,
    required this.password
  });

}

class RegisterDto {
  final String email;
  final String password;

  RegisterDto({
    required this.email,
    required this.password
  });
}

abstract class IAuthRepository{

  Future<Result<String>> login(LoginDto dto);

  Future<Result<String>> register(RegisterDto dto);

  Future<Result<String?>> getToken();

  Future<Result<String>> setToken(String token);

  Future<Result<bool>> checkAuth(String token);

}