

import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';

class LoginUseCase extends IUseCase<LoginDto, String> {
  final IAuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<Result<String>> execute(LoginDto dto) async {
    return await authRepository.login(dto);
  }
}