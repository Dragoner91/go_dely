import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/auth/auth_repository_provider.dart';
import 'package:go_dely/domain/users/user.dart';
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

class ContentRegister extends ConsumerStatefulWidget {
  const ContentRegister({super.key});

  @override
  ConsumerState<ContentRegister> createState() => _ContentRegisterState();
}

class _ContentRegisterState extends ConsumerState<ContentRegister> {
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    String email = '';
    String password = '';
    String fullname = '';
    String ci = '';
    String phone = '';
    bool mostrarTexto = false;
    String texto = 'User registered correctly' ;
    bool mostrarTexto2 = false;
    String texto2 = 'An error has occurred' ;

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

    void actualizarValores(String nuevoTexto, String variable) {
      if (variable == 'Email'){
        email = nuevoTexto;
      }
      if (variable == 'Password'){
        password = nuevoTexto;
      }
      if (variable == 'Full name'){
        fullname = nuevoTexto;
      }
      if (variable == 'CI'){
        ci = nuevoTexto;
      }
      if (variable == 'Phone number'){
        phone = nuevoTexto;
      }
      
    }


    void registerUser() async {
      
      if (email != '' && password != '' && fullname != '' && ci != '' && phone != ''){
        User usuario = User( 
          email: email,
          fullname: fullname,
          password: password,
          phone: phone,
          ci: ci,
        );

          var response = await ref.read(authRepositoryProvider).register(usuario);

          if (response.unwrap() != ""){
            //print(response);
            setState(() {
              mostrarTexto = true;
              mostrarTexto2 = false;
            });


          }
          else{
            setState(() {
              mostrarTexto2 = true;
              mostrarTexto = false;
            });
          }
      }
      else{
        setState(() {
          mostrarTexto2 = true;
          mostrarTexto = false;
        });
      }
    } 

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Column(
            children: [
              Image.asset(
                'assets/GoDely-Logo.png',
                height: 120,
                width: 120,
              ),
              const Padding(
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
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                child: ElevatedButton(
                    onPressed: () {registerUser();},
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(const Size(250, 40)),
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
              if (mostrarTexto) Text(texto),
              if (mostrarTexto2) Text(texto2),
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