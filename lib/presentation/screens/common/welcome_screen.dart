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

  Future<void> changeScreen(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1700));
    context.go("/welcome");
  }

  bool isAnimating = false;

  @override
  Widget build(BuildContext context) {

    
    
    return Scaffold(
      backgroundColor: const Color(0xFF94ED8C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeInLeftBig(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 1000),
            onFinish: (direction) {
              setState(() {
                isAnimating = !isAnimating;
                changeScreen(context);
              });
            },
            child: FadeOutRightBig(
              duration: const Duration(milliseconds: 1000), 
              animate: isAnimating,
              delay: const Duration(milliseconds: 1100),
              child: Image.asset('assets/GoDely-Logo.png'),)
            ),
          const SizedBox(height: 10,),
          FadeInLeftBig(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 1000),
            child: FadeOutRightBig(
              duration: const Duration(milliseconds: 1000),
              animate: isAnimating,
              delay: const Duration(milliseconds: 1100),
              child: const Text(
                "More than Delivery, Experiences",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
      );
  }
}