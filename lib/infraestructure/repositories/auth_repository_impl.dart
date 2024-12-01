import 'package:go_dely/domain/datasources/auth_datasource.dart';
import 'package:go_dely/domain/entities/users/auth.dart';
import 'package:go_dely/domain/entities/users/user.dart';
import 'package:go_dely/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl extends AuthRepository {

  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});


  @override
  Future<String> login(Auth auth){
    return datasource.login(auth);
  }

  @override
  Future<String> register(User user){
    return datasource.register(user);
  }

}