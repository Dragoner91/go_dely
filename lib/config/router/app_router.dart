import 'package:go_dely/presentation/screens/common/welcome_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:go_dely/presentation/screens.dart';




//*borrar despues
import 'package:go_dely/presentation/screens/common/home_provisional.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/welcome',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeProvisional(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ), 
  ],
);