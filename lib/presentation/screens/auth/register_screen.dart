import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
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
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
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

              Authtextfield(campo: 'Full name'),
              Authtextfield(campo: 'CI'),
              Authtextfield(campo: 'Phone number'),
              Authtextfield(campo: 'Email'),
              Authtextfield(campo: 'Password'),

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