import 'package:go_dely/domain/entities/users/user.dart';

abstract class AuthDatasource{

  Future<String> login(user user);

  Future<String> register(user user);
}