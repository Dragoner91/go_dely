import 'package:go_dely/domain/datasources/auth_datasource.dart';
import 'package:go_dely/domain/entities/users/user.dart';
import 'package:go_dely/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl extends AuthRepository {

  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});


  @override
  Future<String> login(user user){
    return datasource.login(user);
  }

  @override
  Future<String> register(user user){
    return datasource.register(user);
  }

}