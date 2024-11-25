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
        //'page': page
      }
    );

    final jsonData = jsonDecode(response.data);

    final String token = jsonData['token'];

    

    return token;
    
  }

  @override
  Future<String> register(User user) async {
    final response = await dio.post('/auth/register',
      queryParameters: {
        
      }
    );

    final jsonData = jsonDecode(response.data);

    final String respuesta = jsonData['id'];

    

    return respuesta;
  }


}