import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_dely/presentation/widgets/common/textfield.dart';
import 'package:go_router/go_router.dart';

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

class Logincontent extends StatefulWidget {
  const Logincontent({super.key});

  @override
  State<Logincontent> createState() => _LogincontentState();
}

class _LogincontentState extends State<Logincontent> {
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
              Authtextfield(campo: 'Email'),
              Authtextfield(campo: 'Password'),
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
