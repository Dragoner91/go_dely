import 'package:go_dely/domain/entities/users/user.dart';

abstract class AuthRepository{

  Future<String> login(user user);

  Future<String> register(user user);


}