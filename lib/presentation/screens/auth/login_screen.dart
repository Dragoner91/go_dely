import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/domain/entities/users/user.dart';
import 'package:go_dely/infraestructure/datasources/auth_db_datasource.dart';
import 'package:go_dely/infraestructure/repositories/auth_repository_impl.dart';
import 'package:go_dely/presentation/providers/auth/auth_provider.dart';
import 'package:go_dely/presentation/widgets/common/textfield.dart';
import 'package:go_router/go_router.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();
    return FadeIn(
      child: Scaffold(
        key: scaffoldkey,
        body: const Logincontent(),
      ),
    );
  }
}

class Logincontent extends ConsumerStatefulWidget {
  const Logincontent({super.key});

  @override
  ConsumerState<Logincontent> createState() => _LogincontentState();
}

class _LogincontentState extends ConsumerState<Logincontent> {
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    //late SharedPreferences prefs;
    String email = '';
    String password = '';


    void actualizarValores(String nuevoTexto, String variable) {
      if (variable == 'Email'){
        email = nuevoTexto;
      };
      if (variable == 'Password'){
        password = nuevoTexto;
      }
      
    }

    /*void initSharedPref() async{
      prefs = await SharedPreferences.getInstance();
    }*/

    void Login() async{
      /*final dio = Dio(
      BaseOptions(
      baseUrl: Environment.verdeAPI,
      queryParameters: {
        
      }
    )
  );*/
      if (email != '' && password != '' ){
         user usuario = user(    
          "",
          "",
          "",
          email,
          password
          );

          var token = "";
          token = AuthRepositoryImpl(datasource: AuthDbDatasource()).login(usuario).toString();
          if (token != ""){
            ref.read(AuthProvider.notifier).update((Token) => token);

            context.go("/home");

          }
  
    /*try {
    final response = await dio.post('/auth/login', data: data);
    final jsonData = jsonDecode(response.data);
    if (response.statusCode == 200) {
      print('Welcome');
      var token = jsonData['token'];
      ref.read(AuthProvider.notifier).update((Token) => token);
      context.go("/home");
    } else {
      print('Error: ${response.statusCode}');
    }
    } catch (e) {
    print('Error al enviar la solicitud: $e');
    }*/

      }
    } 

    
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
          child: Column(
            children: [
              Image.asset(
                'assets/GoDely-Logo.png',
                height: 120,
                width: 120,
              ),
              Padding(
                //padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                padding: EdgeInsets.fromLTRB(0,130, 0, 35),
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                  height: 120
              ),
              Authtextfield(campo: 'Email',callback: actualizarValores),
              Authtextfield(campo: 'Password',callback: actualizarValores),
              Text(
                'Forgot your password?',
                style: textStyles.bodyLarge,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(250, 40)),
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Text(
                    'Don\'t have an account?',
                    style: textStyles.bodyLarge,
                  ),
                  TextButton(
                      onPressed: () {
                        context.go("/register");
                      },
                      child: Text(
                        'Register',
                        style: textStyles.bodyLarge,
                      )),
                  Expanded(child: Container()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
