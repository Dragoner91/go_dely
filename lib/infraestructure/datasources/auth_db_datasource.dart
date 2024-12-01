import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/domain/datasources/auth_datasource.dart';
import 'package:go_dely/domain/entities/users/auth.dart';
import 'package:go_dely/domain/entities/users/user.dart';


class AuthDbDatasource extends AuthDatasource{

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.verdeAPI,
      queryParameters: {
        
      }
    )
  );

  @override
  Future<String> login(Auth auth) async{

    final response = await dio.post('/auth/login',
    queryParameters: {
        'user_email': auth.user_email, 
        'user_password': auth.user_password
        
      }
      
      
    );
   

    final jsonData = jsonDecode(response.data);

    if (response.statusCode == 200) {
      final String token = jsonData['token'];
      print('welcome');

      return token;

    }
    else{
      print('An error has occurred try again');
      return 'error';
    }


    
  }

  @override
  Future<String> register(User user) async {
    final response = await dio.post('/auth/register',
      queryParameters: {
        'user_email': user.email, 
        'user_password': user.password
        
      }
    );

    final jsonData = jsonDecode(response.data);

    if (response.statusCode == 200) {
      final String respuesta = jsonData['id'];
      print('created user');

      return respuesta;

    }
    else{
      print('An error has occurred try again');
      return 'An error has occurred try again';
    }

  }
}