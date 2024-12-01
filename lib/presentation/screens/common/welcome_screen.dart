import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class WelcomeScreen extends StatefulWidget {

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final String name = "WelcomeScreen";

  Future<void> changeScreen(BuildContext context, String route) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    context.go(route);
  }

  bool isAnimating = false;

  @override
  Widget build(BuildContext context) {

    
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10), //*implementar seleccionar api de otros equipos
            child: IconButton(
            onPressed: () {
              
            }, 
            icon: const Icon(Icons.settings, size: 25,)
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFF94ED8C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInLeftBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 1000),
                    child: FadeOutRightBig(
                      duration: const Duration(milliseconds: 1000), 
                      animate: isAnimating,
                      child: Image.asset('assets/GoDely-Logo.png')
                    )
                  ),
                  const SizedBox(height: 10,),
                  FadeInLeftBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 1000),
                    child: FadeOutRightBig(
                      duration: const Duration(milliseconds: 1000),
                      animate: isAnimating,
                      child: const Text(
                        "More than Delivery, Experiences",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          
          const SizedBox(height: 200,),
          FilledButton(
            onPressed: () {
              setState(() {
                isAnimating = !isAnimating;
                changeScreen(context, "/login");
              });
            },
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(MediaQuery.of(context).size.width * 0.65, 45)),
              backgroundColor: WidgetStateProperty.all(const Color.fromARGB(206, 0, 0, 0)),
            ), 
            child: const Text("Login or Register", style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
          const SizedBox(height: 10,),
          OutlinedButton(
            onPressed: () {
              setState(() {
                isAnimating = !isAnimating;
                changeScreen(context, "/home");
              });
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 2, color: Colors.black),
            ),
            child: const Text("Continue Without Login", style: TextStyle(color: Colors.black, fontSize: 16),),
          )
        ],
      ),
      );
  }
}