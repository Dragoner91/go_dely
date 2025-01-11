import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';

class RegisterUseCase extends IUseCase<RegisterDto, String> {
  final IAuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  @override
  Future<Result<String>> execute(RegisterDto dto) async {
    return await authRepository.register(dto);
  }
}