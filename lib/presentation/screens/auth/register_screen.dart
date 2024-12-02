import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_dely/domain/entities/users/user.dart';
import 'package:go_dely/infraestructure/datasources/auth_db_datasource.dart';
import 'package:go_dely/infraestructure/repositories/auth_repository_impl.dart';
import 'package:go_router/go_router.dart';





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

  late String email;
  late String password;
  late String fullname;
  late String ci;
  late String phone;
  late bool mostrarTexto;
  late String texto;
  late bool mostrarTexto2;
  late String texto2;
  late bool mostrarTexto3;
  late String texto3;

  void initState() {
    super.initState();
    email = '';
    password = '';
    fullname = '';
    ci = '';
    phone = '';
    mostrarTexto = false;
    texto = 'There has been an error, try later' ;
    mostrarTexto2 = false;
    texto2 = 'All fields are mandatory' ;
    mostrarTexto3 = false;
    texto3 = 'Created user';
  }
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;


    void actualizarEmail(String nuevoTexto) {

        email = nuevoTexto;}

    void actualizarPassword(String nuevoTexto) {

      password = nuevoTexto;
    }

    void actualizarName(String nuevoTexto) {

      fullname = nuevoTexto;
    }

    void actualizarCi(String nuevoTexto) {

      ci = nuevoTexto;
    }

    void actualizarPhone(String nuevoTexto) {

      phone = nuevoTexto;
    }



    void registerUser() async{
      
      if (email != '' && password != '' && fullname != '' && ci != '' && phone != ''){
        User usuario = User( 
          email,
          fullname,
          password,
          phone,
          ci,
        );

        var response = "";
          response = await AuthRepositoryImpl(datasource: AuthDbDatasource()).register(usuario);
          if (response != ""){
            //print(response);
            setState(() {
              mostrarTexto3 = true;
              mostrarTexto2 = false;
              mostrarTexto = true;
            });


          }
          else{
            setState(() {
              mostrarTexto = true;
              mostrarTexto2 = false;
              mostrarTexto3 = false;
              email = '';
              password = '';
            });
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
      else{
        setState(() {
          mostrarTexto2 = true;
          mostrarTexto = false;
          mostrarTexto3 = false;
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
                //padding: EdgeInsets.symmetric(vertical: 75, horizontal: 0),
                padding: EdgeInsets.fromLTRB(0,145, 0, 60),
                child: Text(
                  'REGISTER',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),

              Authtextfield(campo: 'Full name',callback: actualizarName),
              Authtextfield(campo: 'CI',callback: actualizarCi),
              Authtextfield(campo: 'Phone number',callback: actualizarPhone),
              Authtextfield(campo: 'Email',callback: actualizarEmail),
              Authtextfield(campo: 'Password',callback: actualizarPassword),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                child: ElevatedButton(
                    onPressed: () {registerUser();},
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
              if (mostrarTexto) Text(texto,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,),),
              if (mostrarTexto2) Text(texto2,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,),),
              if (mostrarTexto3) Text(texto3,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,),),
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