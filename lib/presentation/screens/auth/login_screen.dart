// import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_dely/domain/entities/users/auth.dart';
//import 'package:go_dely/domain/entities/users/user.dart';
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

  late String email;
  late String password;
  late bool mostrarTexto;
  late String texto;
  late bool mostrarTexto2;
  late String texto2;


  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    mostrarTexto = false;
    texto = 'Wrong user or password' ;
    mostrarTexto2 = false;
    texto2 = 'All fields are mandatory' ;

  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    //late SharedPreferences prefs;






    void actualizarEmail(String nuevoTexto) {
          email = nuevoTexto;
    }
    void actualizarPassword(String nuevoTexto) {
      password = nuevoTexto;
    }



    void Login() async{
      
      if (email != '' && password != '' ){
         Auth usuario = Auth(
          email,
          password
          );

          var token = await AuthRepositoryImpl(datasource: AuthDbDatasource()).login(usuario);
          var token2 = token.toString();


          if (token2 != "error"){
            ref.read(AuthProvider.notifier).update((Token) => token);
            context.go("/home");

            
          }
          else {
            setState(() {
              mostrarTexto = true;
              mostrarTexto2 = false;
              email = '';
              password = '';
            });
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
      else {
        setState(() {
          mostrarTexto2 = true;
          mostrarTexto = false;
        });
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Column(
            children: [
              Image.asset(
                'assets/GoDely-Logo.png',
                height: 120,
                width: 120,
              ),
              Padding(

                padding: EdgeInsets.fromLTRB(0,145, 0, 35),
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                  height: 120
              ),
              Authtextfield(campo: 'Email',callback: actualizarEmail),
              Authtextfield(campo: 'Password',callback: actualizarPassword),
              Text(
                'Forgot your password?',
                style: textStyles.bodyLarge,
              ),
              if (mostrarTexto)
                Text(texto,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,),
                ),
              if (mostrarTexto2) Text(texto2,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                child: ElevatedButton(
                    onPressed: () {
                      Login();


                      },
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
