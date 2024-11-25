import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/domain/datasources/auth_datasource.dart';
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
  Future<String> login(user user) async{

    final response = await dio.get('/auth/login',
      queryParameters: {
        //'page': page
      }
    );

    final jsonData = jsonDecode(response.data);

    final String token = jsonData['token'];

    

    return token;
    
  }

  @override
  Future<String> register(user user) async {
    final response = await dio.get('/auth/register',
      queryParameters: {
        
      }
    );

    final jsonData = jsonDecode(response.data);

    final String respuesta = jsonData['id'];

    

    return respuesta;
  }


}