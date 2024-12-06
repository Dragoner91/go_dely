// import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_dely/aplication/providers/auth/auth_provider.dart';
import 'package:go_dely/aplication/providers/auth/auth_repository_provider.dart';
import 'package:go_dely/domain/users/auth.dart';
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
    texto = 'Wrong user or password';
    mostrarTexto2 = false;
    texto2 = 'All fields are mandatory';
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



    void login() async {
      if (email != '' && password != '') {

        FocusScope.of(context).unfocus();

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Dialog(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 150,
                  width: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
          },
        );

        AuthDto usuario = AuthDto(
          email,
          password
        );

        var response = await ref.read(authRepositoryProvider).login(usuario);

        Navigator.of(context).pop();

        if (response.isSuccessful) {
          if (response.unwrap() != "error") {
            ref.read(authProvider.notifier).update((token) => response.unwrap());
            ref.read(authRepositoryProvider).setToken(response.unwrap());
            context.go("/home");
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Wrong user or password"),
                actions: [
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the error dialog
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("All fields are mandatory"),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the error dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } 

    
    return Stack(
      children:[ 
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo.png'),

              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: 
            Center(
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
                    
                      padding: EdgeInsets.fromLTRB(0,165, 0, 35),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                        height: 60
                    ),
                    Authtextfield(campo: 'Email', callback: actualizarEmail),
                    Authtextfield(campo: 'Password', callback: actualizarPassword),
                    Text(
                      'Forgot your password?',
                      style: textStyles.bodyLarge,
                    ),
                    if (mostrarTexto)
                      Text(texto,
                      style: textStyles.bodyLarge,),
                    if (mostrarTexto2) Text(texto2,
                      style: textStyles.bodyLarge,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                      child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all(const Size(250, 40)),
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                          ),
                          child: const Text(
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
      ),
      ]
    );
  }
}
