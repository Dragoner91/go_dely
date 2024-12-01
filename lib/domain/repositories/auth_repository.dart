import 'package:go_dely/domain/entities/users/auth.dart';
import 'package:go_dely/domain/entities/users/user.dart';

abstract class AuthRepository{

  Future<String> login(Auth auth);

  Future<String> register(User user);


}