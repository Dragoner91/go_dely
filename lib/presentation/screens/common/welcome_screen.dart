import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/aplication/providers/backend_provider.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_router/go_router.dart';


class WelcomeScreen extends ConsumerStatefulWidget {

  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {

  final String name = "WelcomeScreen";

  Future<void> changeScreen(BuildContext context, String route) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    context.go(route);
  }

  Future<void> checkSessionToken() async {
    final authRepository = GetIt.instance.get<IAuthRepository>();
    final token = await authRepository.getToken();
    if (token.isSuccessful && token.unwrap()!.isNotEmpty) {

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

      final check = await authRepository.checkAuth(token.unwrap()!);
      if(check.isSuccessful && check.unwrap()) {
        context.go("/home");
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Token Expired, you must login again"),
                actions: [
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the error dialog
                      context.go("/login");
                    },
                  ),
                ],
              );
            },
          );
      }
      
    }
  }

  @override
  void initState() {
    super.initState();
    checkSessionToken();
  }

  Color getTeamColor(String team) {
    switch (team) {
      case 'Team Verde':
        return Colors.green;
      case 'Team Naranja':
        return Colors.orange;
      case 'Team Amarillo':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  bool isAnimating = false;
  String selectedTeam = 'Team Verde';

  @override
  Widget build(BuildContext context) {

    
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10), //*implementar seleccionar api de otros equipos
            child: DropdownButton<String>(
              icon: const Icon(Icons.settings, size: 25),
              iconEnabledColor: getTeamColor(selectedTeam), // Cambiar el color del icono
              underline: const SizedBox.shrink(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedTeam = newValue!;
                  ref.read(currentBackendProvider.notifier).update((state) => selectedTeam);
                });
              },
              items: <String>['Team Verde', 'Team Naranja', 'Team Amarillo']
                  .map<DropdownMenuItem<String>>((String value) {
                Color circleColor = getTeamColor(value);
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: circleColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
      backgroundColor: primaryColor,
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
        ],
      ),
      );
  }
}