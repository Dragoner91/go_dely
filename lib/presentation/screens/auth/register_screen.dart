import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/domain/entities/users/user.dart';
import 'package:go_router/go_router.dart';
//import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';



import '../../widgets/common/textfield.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();
    return FadeIn(
      child: Scaffold(
        key: scaffoldkey,
        body: const ContentRegister(),
      ),
    );
  }
}

class ContentRegister extends StatefulWidget {
  const ContentRegister({super.key});

  @override
  State<ContentRegister> createState() => _ContentRegisterState();
}

class _ContentRegisterState extends State<ContentRegister> {
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    String Email = '';
    String Password = '';
    String Fullname = '';
    String CI = '';
    String Phone = '';
    void actualizarValores(String nuevoTexto, String variable) {
      if (variable == 'Email'){
        Email = nuevoTexto;
      };
      if (variable == 'Password'){
        Password = nuevoTexto;
      };
      if (variable == 'Full name'){
        Fullname = nuevoTexto;
      };
      if (variable == 'CI'){
        CI = nuevoTexto;
      };
      if (variable == 'Phone number'){
        Phone = nuevoTexto;
      };
      
    }


    void registerUser() async{
      final dio = Dio(
      BaseOptions(
      baseUrl: Environment.verdeAPI,
      queryParameters: {
        
      }
    )
  );
      if (Email != '' && Password != '' && Fullname != '' && CI != '' && Phone != ''){
        var user = {
          "Email":Email,
          "name": Fullname,
          "Password":Password,
          "Phone":Phone,
          "CI":CI,
        };
          final data = {
          'cuerpo': user,
          };
  
    try {
    final response = await dio.post('/auth/register', data: data);
    if (response.statusCode == 200) {
      print('Usuario registrado');
    } else {
      print('Error al registar el ususario: ${response.statusCode}');
    }
    } catch (e) {
    print('Error al enviar la solicitud: $e');
    }

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
                //padding: EdgeInsets.symmetric(vertical: 75, horizontal: 0),
                padding: EdgeInsets.fromLTRB(0,130, 0, 60),
                child: Text(
                  'REGISTER',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),

              Authtextfield(campo: 'Full name',callback: actualizarValores),
              Authtextfield(campo: 'CI',callback: actualizarValores),
              Authtextfield(campo: 'Phone number',callback: actualizarValores),
              Authtextfield(campo: 'Email',callback: actualizarValores),
              Authtextfield(campo: 'Password',callback: actualizarValores),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(250, 40)),
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Text(
                    'Already have an account?',
                    style: textStyles.bodyLarge,
                  ),
                  TextButton(
                      onPressed: () {

                        context.go("/login");
                      },
                      child: Text(
                        'Log in',
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