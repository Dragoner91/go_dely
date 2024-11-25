import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/domain/entities/users/user.dart';
import 'package:go_dely/infraestructure/datasources/auth_db_datasource.dart';
import 'package:go_dely/infraestructure/repositories/auth_repository_impl.dart';
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
    String email = '';
    String password = '';
    String fullname = '';
    String ci = '';
    String phone = '';
    void actualizarValores(String nuevoTexto, String variable) {
      if (variable == 'Email'){
        email = nuevoTexto;
      };
      if (variable == 'Password'){
        password = nuevoTexto;
      };
      if (variable == 'Full name'){
        fullname = nuevoTexto;
      };
      if (variable == 'CI'){
        ci = nuevoTexto;
      };
      if (variable == 'Phone number'){
        phone = nuevoTexto;
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
      if (email != '' && password != '' && fullname != '' && ci != '' && phone != ''){
        User usuario = User( 
          email,
          fullname,
          password,
          phone,
          ci,
        );

        var response = "";
          response = AuthRepositoryImpl(datasource: AuthDbDatasource()).register(usuario).toString();
          if (response != ""){
            print(response);

          }
        
          /*final data = {
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